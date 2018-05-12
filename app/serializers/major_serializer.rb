# == Schema Information
#
# Table name: majors
#
#  id                :bigint(8)        not null, primary key
#  name              :string
#  category          :integer
#  description       :text
#  video_url         :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  comments_count    :integer          default(0)
#  short_description :text
#

class MajorSerializer < ActiveModel::Serializer
  include ImageableSerializer

  attributes :id, :name, :category, :logo, :short_description, :description,
             :video_url, :comments_count, :created_at

  def self.eager_load_relation(relation)
    relation.with_attached_logo
  end

  def logo
    image_hash(object.logo, :thumb, :medium)
  end
end
