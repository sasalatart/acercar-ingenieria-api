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

class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :owner_id, :action_type, :notifyable_type, :notifyable_id,
             :notifyable_meta, :seen, :created_at

  belongs_to :notificator, class_name: 'User',
                           serializer: UserSummarySerializer

  NOTIFYABLES_META_COLUMNS = {
    discussion: %w[title],
    article: %w[major_id title],
    comment: %w[commentable_type commentable_id content]
  }.freeze

  def self.eager_load_relation(relation)
    relation.includes(:notificator, :notifyable)
  end

  def notifyable_meta
    columns = NOTIFYABLES_META_COLUMNS[object.notifyable_type.underscore.to_sym]
    object.notifyable.attributes.slice(*columns)
  end
end
