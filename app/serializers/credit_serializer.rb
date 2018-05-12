# == Schema Information
#
# Table name: credits
#
#  id            :bigint(8)        not null, primary key
#  resource_name :string
#  resource_url  :string
#  author_name   :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class CreditSerializer < ActiveModel::Serializer
  include ImageableSerializer

  attributes :id, :resource, :resource_name, :resource_url, :author_name,
             :created_at

  def self.eager_load_relation(relation)
    relation.with_attached_resource
  end

  def resource
    image_hash(object.resource, :thumb, :medium)
  end
end
