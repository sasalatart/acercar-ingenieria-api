# == Schema Information
#
# Table name: credits
#
#  id                    :integer          not null, primary key
#  resource_name         :string
#  resource_url          :string
#  author_name           :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  resource_file_name    :string
#  resource_content_type :string
#  resource_file_size    :integer
#  resource_updated_at   :datetime
#

class CreditSerializer < ActiveModel::Serializer
  include Imageable

  attributes :id, :resource, :resource_name, :resource_url, :author_name,
             :created_at

  def resource
    image_hash(object.resource, :thumb, :medium)
  end
end
