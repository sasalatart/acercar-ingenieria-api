# == Schema Information
#
# Table name: notifications
#
#  id              :bigint(8)        not null, primary key
#  action_type     :integer
#  seen            :boolean          default(FALSE)
#  owner_id        :bigint(8)
#  notificator_id  :bigint(8)
#  notifyable_type :string
#  notifyable_id   :bigint(8)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Notification < ApplicationRecord
  enum action_type: NotifyableModel::NOTIFICATION_TYPES

  scope :seen, -> { where(seen: true) }
  scope :unseen, -> { where(seen: false) }

  belongs_to :owner, class_name: :User,
                     inverse_of: :notifications

  belongs_to :notificator, class_name: :User,
                           optional: true,
                           inverse_of: :sent_notifications

  belongs_to :notifyable, polymorphic: true

  def self.trigger_send_count_for(user_id, count)
    return unless ENV['WS_ENABLED']

    data = { count: count, timestamp: Time.now.utc }
    Pusher.trigger("private-user-#{user_id}", 'notifications-count', data)
  end

  def self.trigger_send_multiple_counts(to_ids)
    counts_per_user = Notification.where(owner_id: to_ids, seen: false)
                                  .group(:owner_id)
                                  .count

    counts_per_user.each do |owner_id, count|
      trigger_send_count_for(owner_id, count)
    end
  end
end
