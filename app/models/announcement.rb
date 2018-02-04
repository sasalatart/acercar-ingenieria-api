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
  include Sanitizable

  before_save :sanitize_attributes

  scope :pinned, -> { where(pinned: true) }

  has_attached_file :picture,
                    styles: { large: '1440x880>' },
                    convert_options: { display: '-quality 90 -strip' },
                    dependent: :destroy

  validates_attachment :picture, content_type: { content_type: /\Aimage\/.*\z/ },
                                 size: { in: 0..5.megabytes }

  private

  def sanitize_attributes
    sanitize(:text)
  end
end
