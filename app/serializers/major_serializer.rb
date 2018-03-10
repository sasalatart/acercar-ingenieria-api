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
#  logo_file_name    :string
#  logo_content_type :string
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#  comments_count    :integer          default(0)
#  short_description :text
#

class MajorSerializer < ActiveModel::Serializer
  include Imageable

  attributes :id, :name, :category, :logo, :short_description, :description,
             :video_url, :comments_count, :created_at

  def logo
    image_hash(object.logo, :thumb, :medium)
  end
end
