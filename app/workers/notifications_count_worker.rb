class NotificationsCountWorker
  include Sidekiq::Worker

  def perform(to_ids)
    filtered_to_ids = User.where(id: to_ids)
                          .where('current_sign_in_at > ?', Time.now - 2.weeks)
                          .pluck(:id)

    Notification.trigger_send_multiple_counts(filtered_to_ids)
  end
end
