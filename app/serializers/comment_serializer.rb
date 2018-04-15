# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :text
#  author_id        :integer
#  commentable_type :string
#  commentable_id   :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  likes_count      :integer          default(0)
#  comments_count   :integer          default(0)
#

class CommentSerializer < ActiveModel::Serializer
  include SelfEnrollable
  include Likeable

  MAX_CHILD_COMMENTS_TO_RENDER = 10

  attributes :id, :content, :commentable_id, :commentable_type,
             :child_comments, :extra_comments, :created_at

  belongs_to :author, class_name: 'User',
                      serializer: UserSummarySerializer

  def self.eager_load_relation(relation)
    relation.includes(:author)
  end

  def child_comments
    ActiveModelSerializers::SerializableResource.new(
      object.child_comments.limit(MAX_CHILD_COMMENTS_TO_RENDER),
      scope: current_user,
      scope_name: :current_user,
      each_serializer: CommentChildSerializer
    )
  end

  def extra_comments
    [0, object.child_comments.count - MAX_CHILD_COMMENTS_TO_RENDER].max
  end
end
