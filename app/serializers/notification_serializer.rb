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

class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :action_type, :seen, :notifyable_type, :created_at

  belongs_to :owner, class_name: 'User'
  belongs_to :notificator, class_name: 'User'
  belongs_to :notifyable, polymorphic: true
end
