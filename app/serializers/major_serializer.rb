# == Schema Information
#
# Table name: majors
#
#  id                :integer          not null, primary key
#  name              :string
#  category          :integer
#  description       :text
#  video_url_code    :string
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
  attributes :id, :name, :category, :logo, :short_description, :description,
             :video_url_code, :comments_count, :created_at

  def logo
    return nil unless object.logo.exists?
    { medium: object.logo.url(:medium) }
  end
end
