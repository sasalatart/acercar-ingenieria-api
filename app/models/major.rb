# == Schema Information
#
# Table name: majors
#
#  id                :bigint(8)        not null, primary key
#  name              :string
#  category          :integer
#  description       :text
#  video_url         :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  comments_count    :integer          default(0)
#  short_description :text
#

class Major < ApplicationRecord
  include SanitizableModel

  resourcify

  enum category: { disciplinary: 0, interdisciplinary: 1 }

  before_save :sanitize_attributes

  has_many :major_users, dependent: :destroy
  has_many :users, through: :major_users
  has_many :questions, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :video_links, as: :video_linkable, dependent: :destroy

  has_one_attached :logo

  validates :name, presence: true,
                   uniqueness: true

  validates :category, presence: true,
                       inclusion: { in: categories.keys }

  validates :short_description, presence: true,
                                length: { maximum: 300 }

  validates :description, presence: true
  validates :video_url, presence: true
  validates :logo, image: { max_size: 2.megabytes }

  def admins
    User.with_role(:major_admin, self)
  end

  def self.ids_where_is_admin(user)
    Major.with_role(:major_admin, user).pluck(:id)
  end

  private

  def sanitize_attributes
    sanitize(:name, :description, :video_url)
  end
end
