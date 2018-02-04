# == Schema Information
#
# Table name: attachments
#
#  id                    :integer          not null, primary key
#  attachable_type       :string
#  attachable_id         :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  document_file_name    :string
#  document_content_type :string
#  document_file_size    :integer
#  document_updated_at   :datetime
#

class AttachmentSerializer < ActiveModel::Serializer
  attributes :id, :attachable_type, :attachable_id, :created_at,
             :document_file_name, :document_content_type, :document_file_size, :url

  def url
    object.document.url
  end
end
