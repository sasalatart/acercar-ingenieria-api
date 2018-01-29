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

class Attachment < ApplicationRecord
  belongs_to :attachable, polymorphic: true

  has_attached_file :document, dependent: :destroy

  validates_attachment_presence :document
  validates_attachment_size :document, less_than: 5.megabytes
  do_not_validate_attachment_file_type :document

  validate :file_format

  private

  def file_format
    return unless document_file_name =~ /(.*\.?(php|pl|exe|pm|cfm|asp|js))/
    errors.add(:document_content_type, 'Invalid format')
  end
end
