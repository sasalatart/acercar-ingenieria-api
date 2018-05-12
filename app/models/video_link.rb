# == Schema Information
#
# Table name: video_links
#
#  id                  :bigint(8)        not null, primary key
#  title               :string
#  url                 :string
#  pinned              :boolean          default(FALSE)
#  video_linkable_type :string
#  video_linkable_id   :bigint(8)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class VideoLink < ApplicationRecord
  include SanitizableModel

  before_save :sanitize_attributes

  belongs_to :video_linkable, polymorphic: true

  validates :title, presence: true
  validates :url, presence: true

  private

  def sanitize_attributes
    sanitize(:title, :url)
  end
end
