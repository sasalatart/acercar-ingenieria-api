# == Schema Information
#
# Table name: articles
#
#  id                   :integer          not null, primary key
#  title                :string
#  short_description    :text
#  content              :text
#  major_id             :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  likes_count          :integer          default(0)
#  comments_count       :integer          default(0)
#  author_id            :integer
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

class Article < ApplicationRecord
  include Enrollable
  include Notifyable
  include PgSearch
  include Sanitizable

  before_save :sanitize_attributes
  after_create :enroll_and_notify

  pg_search_scope :search_for,
                  against: { title: 'A', short_description: 'B' },
                  using: { tsearch: { prefix: true, any_word: true } }

  acts_as_taggable_on :categories

  belongs_to :author, class_name: :User
  belongs_to :major, optional: true

  has_many :attachments, as: :attachable, dependent: :destroy, inverse_of: :attachable
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  has_attached_file :picture, styles: { medium: '200x200>' },
                              convert_options: { display: '-quality 90 -strip' },
                              dependent: :destroy

  accepts_nested_attributes_for :attachments, allow_destroy: true

  validates :title, presence: true, uniqueness: true
  validates :short_description, presence: true, length: { maximum: 300 }
  validates :content, presence: true

  validate :only_allowed_categories
  validate :only_allowed_majors

  validates_attachment :picture, content_type: { content_type: /\Aimage\/.*\z/ },
                                 size: { in: 0..1.megabytes }

  def self.scoped(params)
    major_id, category_list, search = params.values_at(:major_id, :category_list, :search)
    @articles = major_id ? Article.where(major_id: major_id) : Article.all
    @articles = @articles.tagged_with(category_list) if category_list
    @articles = @articles.search_for(search) if search
    @articles.order(created_at: :desc)
  end

  private

  def sanitize_attributes
    sanitize(:title, :short_description, :content)
  end

  def enroll_and_notify
    enroll!(author)

    users = major ? major.users : User.all
    notify(TYPES[:published], author_id, users.pluck(:id))
  end

  def only_allowed_categories
    return if (category_list - Category.all.pluck(:name)).empty?
    errors.add :base, :inexistent_category
  end

  def only_allowed_majors
    return unless major_id && major_id_changed? && !author.majors.find_by(id: major_id)
    errors.add :major, :author_not_in_major
  end
end
