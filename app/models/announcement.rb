# == Schema Information
#
# Table name: announcements
#
#  id         :bigint(8)        not null, primary key
#  pinned     :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Announcement < ApplicationRecord
  scope :pinned, -> { where(pinned: true).order(created_at: :desc) }

  has_one_attached :picture

  validates :picture, image: { presence: true, max_size: 5.megabytes }
end
