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

class Comment < ApplicationRecord
  scope :primary, -> { where(parent_comment_id: nil) }

  belongs_to :author, class_name: :User

  belongs_to :commentable, polymorphic: true

  belongs_to :parent_comment, class_name: :Comment,
                              optional: true

  has_many :child_comments, class_name: :Comment,
                            foreign_key: :parent_comment_id,
                            dependent: :destroy

  has_many :likes, as: :likeable, dependent: :destroy

  validates :content, presence: true,
                      length: { maximum: 1000 }

  validate :parent_comment_can_not_have_parent_comment

  private

  def parent_comment_can_not_have_parent_comment
    return unless parent_comment && parent_comment.parent_comment_id
    errors.add(:parent_comment_id, "can't reply to another reply")
  end
end
