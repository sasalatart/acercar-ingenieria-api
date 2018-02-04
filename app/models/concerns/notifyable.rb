module Notifyable
  extend ActiveSupport::Concern

  TYPES = { commented: 1, answered: 2, published: 3 }.freeze

  included do
    has_many :notifications, as: :notifyable, dependent: :destroy
  end

  def notify(action_type, notificator, to_ids = nil)
    to_user_ids = to_ids || enrolled_users.pluck(:id)

    notifications_to_create = to_user_ids.map do |owner_id|
      next if owner_id == notificator.id
      { owner_id: owner_id, notificator: notificator, action_type: action_type, notifyable: self }
    end.compact

    return unless notifications_to_create.size.nonzero?
    Notification.create!(notifications_to_create)
  end
end