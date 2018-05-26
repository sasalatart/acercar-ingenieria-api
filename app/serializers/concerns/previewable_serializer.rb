module PreviewableSerializer
  include ImageableSerializer
  extend ActiveSupport::Concern

  included do
    attributes :preview_url
  end

  def preview_url
    return image_hash(object.preview, :medium)[:medium] if object.preview.attached?

    picture = object.attachments.detect do |attachment|
      attachment.variable? || attachment.previewable?
    end
    return nil unless picture

    method = picture.variable? ? :variant : :preview
    resize_options = { resize: ImageableSerializer::SIZES[:medium] }
    rails_representation_url(picture.send(method, resize_options))
  end
end
