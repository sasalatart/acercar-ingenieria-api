# == Schema Information
#
# Table name: majors
#
#  id                :integer          not null, primary key
#  name              :string
#  category          :integer
#  description       :text
#  video_url         :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  comments_count    :integer          default(0)
#  short_description :text
#

class MajorSummarySerializer < ActiveModel::Serializer
  include ImageableSerializer

  attributes :id, :name, :category, :logo

  def self.eager_load_relation(relation)
    relation.with_attached_logo
  end

  def logo
    image_hash(object.logo, :thumb, :medium)
  end
end
