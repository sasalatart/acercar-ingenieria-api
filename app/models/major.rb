# == Schema Information
#
# Table name: majors
#
#  id             :integer          not null, primary key
#  name           :string
#  category       :integer
#  description    :text
#  video_url_code :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Major < ApplicationRecord
  enum category: { disciplinary: 0, interdisciplinary: 1 }

  has_many :major_users, dependent: :destroy
  has_many :users, through: :major_users

  validates :category, :description, :video_url_code, presence: true

  validates :name, presence: true,
                   uniqueness: true

  validates :category, presence: true,
                       inclusion: { in: categories.keys }
end
