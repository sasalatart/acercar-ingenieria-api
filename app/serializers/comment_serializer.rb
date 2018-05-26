# == Schema Information
#
# Table name: comments
#
#  id                   :bigint(8)        not null, primary key
#  content              :text
#  author_id            :bigint(8)
#  commentable_type     :string
#  commentable_id       :bigint(8)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  likes_count          :integer          default(0)
#  comments_count       :integer          default(0)
#  approved_commentable :boolean          default(TRUE)
#

class CommentSerializer < ActiveModel::Serializer
  include EnrollableSerializer
  include LikeableSerializer

  MAX_CHILD_COMMENTS_TO_RENDER = 8

  attributes :id, :commentable_type, :commentable_id, :approved_commentable,
             :content, :child_comments, :extra_comments, :created_at

  belongs_to :author, class_name: 'User',
                      serializer: UserSummarySerializer

  def self.eager_load_relation(relation)
    relation.includes(author: { avatar_attachment: :blob })
  end

  def child_comments
    children = object.child_comments.includes(author: { avatar_attachment: :blob })
    ActiveModelSerializers::SerializableResource.new(
      children.limit(MAX_CHILD_COMMENTS_TO_RENDER),
      scope: current_user,
      scope_name: :current_user,
      each_serializer: CommentChildSerializer
    )
  end

  def extra_comments
    [0, object.child_comments.count - MAX_CHILD_COMMENTS_TO_RENDER].max
  end
end
