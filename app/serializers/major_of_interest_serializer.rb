class MajorOfInterestSerializer < ActiveModel::Serializer
  delegate :name, :category, to: 'object.major'

  attributes :id, :major_id, :user_id, :logo, :name, :category

  def logo
    return nil unless object.major.logo.exists?

    logo = object.major.logo
    { thumb: logo.url(:thumb), medium: logo.url(:medium) }
  end
end
