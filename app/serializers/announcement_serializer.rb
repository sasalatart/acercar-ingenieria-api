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

class AnnouncementSerializer < ActiveModel::Serializer
  include Imageable

  attributes :id, :pinned, :picture, :created_at

  def picture
    image_hash(object.picture, :thumb, :medium, :large)
  end
end
