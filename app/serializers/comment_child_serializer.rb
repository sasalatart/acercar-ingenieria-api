# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  content           :text
#  author_id         :integer
#  commentable_type  :string
#  commentable_id    :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  likes_count       :integer          default(0)
#  approved_commentable :boolean          default(TRUE)
#

class CommentChildSerializer < ActiveModel::Serializer
  include LikeableSerializer

  attributes :id, :commentable_type, :commentable_id, :approved_commentable,
             :content, :created_at

  belongs_to :author, class_name: 'User',
                      serializer: UserSummarySerializer

  def self.eager_load_relation(relation)
    relation.includes(:author)
  end
end
