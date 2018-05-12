module AttachableSerializer
  include StorableSerializer
  extend ActiveSupport::Concern

  included do
    attributes :attachments
  end

  def attachments
    object.attachments.includes(:blob).map do |attachment|
      blob = attachment.blob
      { id: attachment.id,
        url: rails_blob_url(attachment, disposition: :attachment),
        filename: blob.filename,
        byte_size: blob.byte_size,
        content_type: blob.content_type }
    end
  end
end
