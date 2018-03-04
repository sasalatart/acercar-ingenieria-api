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

class CommentChildSerializer < ActiveModel::Serializer
  include Likeable

  attributes :id, :content, :commentable_id, :commentable_type,
             :parent_comment_id, :created_at

  belongs_to :author, class_name: 'User'

  def self.eager_load_relation(relation)
    relation.includes(:author)
  end
end
