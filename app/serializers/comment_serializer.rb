# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  content           :text
#  author_id         :integer
#  parent_comment_id :integer
#  commentable_type  :string
#  commentable_id    :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  likes_count       :integer          default(0)
#

class CommentSerializer < ActiveModel::Serializer
  include Likeable

  attributes :id, :content, :commentable_id, :commentable_type, :created_at

  belongs_to :author, class_name: 'User'

  has_many :child_comments, class_name: 'Comment',
                            foreign_key: 'parent_comment_id',
                            serializer: CommentChildSerializer
end
