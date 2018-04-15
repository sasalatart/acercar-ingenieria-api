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

  has_many :comments, class_name: :Comment,
                      as: :commentable,
                      dependent: :destroy

  has_many :likes, as: :likeable, dependent: :destroy

  validates :content, presence: true,
                      length: { maximum: 1000 }

  validate :no_replies_to_replies

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
    if child_comment? && !commentable.enrolled_users.find_by(id: author_id)
      return commentable.enroll!(author)
    end

    enroll!(author) unless child_comment?
  end

  def notify_interested
    return unless commentable.respond_to?(:enrolled_users)
    type = child_comment? ? TYPES[:answered] : TYPES[:commented]
    notify(type, author_id, commentable.enrolled_users.pluck(:id))
  end

  def no_replies_to_replies
    return unless child_comment? && commentable.child_comment?
    errors.add(:commentable_id, "can't reply to another reply")
  end
end
