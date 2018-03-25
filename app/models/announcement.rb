# == Schema Information
#
# Table name: announcements
#
#  id                   :integer          not null, primary key
#  pinned               :boolean          default(TRUE)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

class Announcement < ApplicationRecord
  scope :pinned, -> { where(pinned: true).order(created_at: :desc) }

  has_attached_file :picture,
                    styles: { thumb: '75x75>', medium: '200x200>', large: '1440x880>' },
                    convert_options: { display: '-quality 90 -strip' },
                    dependent: :destroy

  validates_attachment :picture, content_type: { content_type: /\Aimage\/.*\z/ },
                                 size: { in: 0..5.megabytes }
end
