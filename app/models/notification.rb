# == Schema Information
#
# Table name: notifications
#
#  id              :integer          not null, primary key
#  action_type     :integer
#  seen            :boolean          default(FALSE)
#  owner_id        :integer
#  notificator_id  :integer
#  notifyable_type :string
#  notifyable_id   :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Notification < ApplicationRecord
  enum action_type: Notifyable::TYPES

  scope :seen, -> { where(seen: true) }
  scope :unseen, -> { where(seen: false) }

  belongs_to :owner, class_name: :User

  belongs_to :notificator, class_name: :User,
                           optional: true

  belongs_to :notifyable, polymorphic: true

  def self.remove_old
    Notification.where('created_at < ?', Time.now - 1.month).destroy
  end
end
