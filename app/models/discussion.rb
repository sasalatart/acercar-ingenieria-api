# == Schema Information
#
# Table name: discussions
#
#  id                :integer          not null, primary key
#  title             :string
#  description       :text
#  pinned            :boolean          default(FALSE)
#  likes_count       :integer          default(0)
#  comments_count    :integer          default(0)
#  impressions_count :integer          default(0)
#  author_id         :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Discussion < ApplicationRecord
  include Attachable
  include Enrollable
  include Notifyable
  include PgSearch
  include Sanitizable

  MAX_TAGS = 5

  before_save :sanitize_attributes
  after_create :enroll_and_notify

  pg_search_scope :search_for,
                  against: :title,
                  using: { tsearch: { prefix: true, any_word: true } }

  acts_as_taggable

  is_impressionable counter_cache: true,
                    unique: true

  belongs_to :author, class_name: :User

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  validates :title, presence: true,
                    length: { minimum: 10, maximum: 255 }

  validates :description, presence: true

  validate :max_tags

  def self.scoped(params)
    author_id, tag_list, search = params.values_at(:author_id, :tag_list, :search)
    @discussions = author_id ? Discussion.where(author_id: author_id) : Discussion.all
    @discussions = @discussions.tagged_with(tag_list) if tag_list
    @discussions = @discussions.search_for(search) if search
    @discussions.order([pinned: :desc, created_at: :desc])
  end

  private

  def enroll_and_notify
    enroll!(author)
    notify(TYPES[:published], author_id, User.all.pluck(:id)) if pinned
  end

  def max_tags
    return unless tag_list && tag_list.size > MAX_TAGS
    errors.add :base, :max_tags_reached, amount: MAX_TAGS
  end

  def sanitize_attributes
    sanitize(:title, :description)
  end
end
