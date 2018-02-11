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

class MajorSummarySerializer < ActiveModel::Serializer
  attributes :id, :name, :category, :logo

  def logo
    return nil unless object.logo.exists?
    { thumb: object.logo.url(:thumb), medium: object.logo.url(:medium) }
  end
end
