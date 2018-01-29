# == Schema Information
#
# Table name: announcements
#
#  id                   :integer          not null, primary key
#  text                 :text
#  pinned               :boolean          default(TRUE)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

class Announcement < ApplicationRecord
  scope :pinned, -> { where(pinned: true) }

  has_attached_file :picture,
                    styles: { thumb: '1440x880>' },
                    convert_options: { display: '-quality 90 -strip' },
                    dependent: :destroy

  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
  validates_attachment_size :picture, less_than: 5.megabytes
end
