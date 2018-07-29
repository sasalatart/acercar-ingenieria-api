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

class Comment < ApplicationRecord
  include EnrollableModel
  include NotifyableModel
  include SanitizableModel

  alias_attribute :child_comments, :comments
  alias_attribute :approved?, :approved_commentable?

  before_save :sanitize_attributes
  after_create :enroll_to_self_and_commentable
  after_create :notify_interested

  belongs_to :author, class_name: :User,
                      inverse_of: :comments

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

  def enroll_to_self_and_commentable
    enroll!(author) unless child_comment?

    return unless commentable.respond_to?(:enroll!)

    commentable.enroll!(author) unless commentable.enrolled_users.find_by(id: author_id)
  end

  def notify_interested
    return unless commentable.respond_to?(:enrolled_users)
    type = child_comment? ? NOTIFICATION_TYPES[:answered] : NOTIFICATION_TYPES[:commented]
    notify(type, author_id, commentable.enrolled_users.pluck(:id))
  end

  def no_replies_to_replies
    return unless child_comment? && commentable.child_comment?
    errors.add(:commentable_id, :invalid_parent_comment)
  end
end
