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
    discussion: %w[author_id title],
    article: %w[author_id major_id title approved],
    comment: %w[commentable_type commentable_id approved_commentable content]
  }.freeze

  def self.eager_load_relation(relation)
    relation.includes(:notifyable, notificator: { avatar_attachment: :blob })
  end

  def notifyable_meta
    columns = NOTIFYABLES_META_COLUMNS[object.notifyable_type.underscore.to_sym]
    object.notifyable.attributes.slice(*columns)
  end
end
