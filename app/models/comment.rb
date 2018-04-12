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

class Comment < ApplicationRecord
  include Sanitizable
  include Enrollable
  include Notifyable

  alias_attribute :child_comments, :comments

  before_save :sanitize_attributes
  after_create :enroll_to_self_or_parent
  after_create :notify_interested

  belongs_to :author, class_name: :User

  belongs_to :commentable, polymorphic: true,
                           counter_cache: true

  belongs_to :parent_comment, class_name: :Comment,
                              optional: true

  has_many :comments, class_name: :Comment,
                      as: :commentable,
                      dependent: :destroy

  has_many :likes, as: :likeable, dependent: :destroy

  validates :content, presence: true,
                      length: { maximum: 1000 }

  validate :parent_comment_can_not_have_parent_comment

  def child_comment?
    commentable_type == Comment.to_s
  end

  def serializer
    child_comment? ? CommentChildSerializer : CommentSerializer
  end

  private

  def sanitize_attributes
    sanitize(:content)
  end

  def enroll_to_self_or_parent
    if parent_comment && !parent_comment.enrolled_users.find_by(id: author_id)
      parent_comment.enroll!(author)
      return
    end

    enroll!(author) unless parent_comment
  end

  def notify_interested
    return unless commentable.respond_to?(:enrolled_users)
    type = child_comment? ? TYPES[:answered] : TYPES[:commented]
    notify(type, author, commentable.enrolled_users.pluck(:id))
  end

  def parent_comment_can_not_have_parent_comment
    return unless parent_comment && parent_comment.child_comment?
    errors.add(:commentable_id, "can't reply to another reply")
  end
end
