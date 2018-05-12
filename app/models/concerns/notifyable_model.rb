module NotifyableModel
  extend ActiveSupport::Concern

  TYPES = { commented: 1, answered: 2, published: 3 }.freeze

  included do
    has_many :notifications, as: :notifyable, dependent: :destroy
  end

  def notify(action_type, notificator_id, to_user_ids = nil)
    to_ids = to_user_ids || enrolled_users.pluck(:id)
    NotifyWorker.perform_async(
      action_type,
      notificator_id,
      to_ids,
      self.class.name,
      id
    )
  end

  def read_notifications_from(owner)
    updated_amount = notifications.where(owner: owner, seen: false)
                                  .update_all(seen: true)
    owner.send_notifications_count if updated_amount > 0
  end

  module ClassMethods
    def read_notifications_from(owner, notifyable_ids)
      query = { notifyable_type: to_s,
                notifyable_id: notifyable_ids,
                owner: owner,
                seen: false }

      updated_amount = Notification.where(query)
                                   .update_all(seen: true)
      owner.send_notifications_count if updated_amount > 0
    end
  end
end
