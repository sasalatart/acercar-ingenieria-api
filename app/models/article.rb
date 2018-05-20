# == Schema Information
#
# Table name: articles
#
#  id                :bigint(8)        not null, primary key
#  title             :string
#  short_description :text
#  content           :text
#  major_id          :bigint(8)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  likes_count       :integer          default(0)
#  comments_count    :integer          default(0)
#  author_id         :bigint(8)
#  approved          :boolean          default(FALSE)
#

class Article < ApplicationRecord
  include AttachableModel
  include EnrollableModel
  include NotifyableModel
  include ApprovableModel
  include ReportableModel
  include SanitizableModel
  include PgSearch

  before_save :sanitize_attributes
  after_create :enroll_and_notify

  pg_search_scope :search_for,
                  against: { title: 'A', short_description: 'B' },
                  using: { tsearch: { prefix: true, any_word: true } }

  scope :approved, -> { where(approved: true) }
  scope :pending, -> { where(approved: false) }

  acts_as_taggable_on :categories

  belongs_to :author, class_name: :User
  belongs_to :major, optional: true

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  has_one_attached :preview

  validates :title, presence: true, uniqueness: true
  validates :short_description, presence: true, length: { maximum: 300 }
  validates :content, presence: true
  validates :attachments, attachments: { max_amount: 5, max_total_size: 10.megabytes }
  validates :preview, image: { max_size: 2.megabytes }

  validate :only_allowed_categories
  validate :only_allowed_majors

  def self.scoped(params)
    major_id, category_list, search, author_id = params.values_at(:major_id, :category_list, :search, :author_id)
    @articles = major_id ? Article.where(major_id: major_id) : Article.all
    @articles = @articles.tagged_with(category_list) if category_list
    @articles = @articles.search_for(search) if search
    @articles = @articles.where(author_id: author_id) if author_id
    @articles.order(created_at: :desc)
  end

  private

  def sanitize_attributes
    sanitize(:title, :short_description, :content)
  end

  def enroll_and_notify
    enroll!(author)

    to_users = major ? User.with_role(:admin) + major.users : User.all
    notify(NOTIFICATION_TYPES[:published], author_id, to_users.pluck(:id).uniq)
  end

  def only_allowed_categories
    return if (category_list - Category.all.pluck(:name)).empty?
    errors.add :base, :inexistent_category
  end

  def only_allowed_majors
    return if author.has_role?(:admin)
    return unless major_id && major_id_changed? && !author.majors.find_by(id: major_id)
    errors.add :major, :author_not_in_major
  end
end
