class NotifyWorker
  include Sidekiq::Worker

  def perform(action_type, notificator_id, to_ids, notifyable_type, notifyable_id)
    to_create = to_ids.map do |owner_id|
      next if owner_id == notificator_id
      { owner_id: owner_id,
        action_type: action_type,
        notificator_id: notificator_id,
        notifyable_type: notifyable_type,
        notifyable_id: notifyable_id }
    end.compact

    return unless to_create.size.nonzero?
    ActiveRecord::Base.transaction { Notification.create!(to_create) }
  end
end
