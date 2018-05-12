class MajorOfInterestSerializer < ActiveModel::Serializer
  include ImageableSerializer

  delegate :name, :category, to: 'object.major'

  attributes :id, :major_id, :user_id, :logo, :name, :category

  def logo
    image_hash(object.major.logo, :thumb, :medium)
  end
end
