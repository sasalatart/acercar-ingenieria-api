# == Schema Information
#
# Table name: majors
#
#  id                :integer          not null, primary key
#  name              :string
#  category          :integer
#  description       :text
#  video_url         :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  logo_file_name    :string
#  logo_content_type :string
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#  comments_count    :integer          default(0)
#  short_description :text
#

class Major < ApplicationRecord
  include Sanitizable

  resourcify

  enum category: { disciplinary: 0, interdisciplinary: 1 }

  before_save :sanitize_attributes

  has_many :major_users, dependent: :destroy
  has_many :users, through: :major_users
  has_many :questions, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :video_links, as: :video_linkable, dependent: :destroy

  has_attached_file :logo, styles: { thumb: '75x75>', medium: '200x200>' },
                           convert_options: { display: '-quality 90 -strip' },
                           dependent: :destroy

  validates :name, presence: true,
                   uniqueness: true

  validates :category, presence: true,
                       inclusion: { in: categories.keys }

  validates :short_description, presence: true,
                                length: { maximum: 300 }

  validates :description, presence: true

  validates_attachment :logo, content_type: { content_type: /\Aimage\/.*\z/ },
                              size: { in: 0..2.megabytes }

  validates :video_url, presence: true

  def admins
    User.with_role(:major_admin, self)
  end

  def self.ids_where_is_admin(user)
    Major.with_role(:major_admin, user).pluck(:id)
  end

  def self.user_admin?(user, major_id)
    return true if user.has_role? :admin
    Major.ids_where_is_admin(user).include? major_id.to_i
  end

  private

  def sanitize_attributes
    sanitize(:name, :description, :video_url)
  end
end
