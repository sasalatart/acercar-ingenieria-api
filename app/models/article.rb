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
  include Sanitizable
  include Enrollable
  include Notifyable

  before_save :sanitize_attributes
  after_create :notify_interested

  scope :of_major, ->(major_id) { where(major_id: major_id) }

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

  validates_attachment :picture, content_type: { content_type: /\Aimage\/.*\z/ },
                                 size: { in: 0..2.megabytes }

  private

  def sanitize_attributes
    sanitize(:title, :short_description, :content)
  end

  def notify_interested
    major && notify(TYPES[:published], author, major.enrolled_users.pluck(:id))
  end

  def only_allowed_categories
    return if (category_list - Category.all.pluck(:name)).empty?
    errors.add :base, 'invalid categories'
  end
end
