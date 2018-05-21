# == Schema Information
#
# Table name: announcements
#
#  id         :bigint(8)        not null, primary key
#  pinned     :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AnnouncementSerializer < ActiveModel::Serializer
  include ImageableSerializer

  attributes :id, :pinned, :picture, :created_at

  def self.eager_load_relation(relation)
    relation.with_attached_picture
  end

  def picture
    image_hash(object.picture, :thumb, :medium, :large)
  end
end
