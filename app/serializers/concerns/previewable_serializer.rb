module PreviewableSerializer
  include ImageableSerializer
  extend ActiveSupport::Concern

  RESIZE_OPTIONS = { resize: ImageableSerializer::SIZES[:medium] }.freeze

  included do
    attributes :preview_url
  end

  def preview_url
    return image_hash(object.preview, :medium)[:medium] if object.preview.attached?

    picture = get_picture(object)
    return nil unless picture

    rails_representation_url(
      picture.send(picture.variable? ? :variant : :preview, RESIZE_OPTIONS)
    )
  end

  private

  def get_picture(object)
    object.attachments.detect do |attachment|
      attachment.variable? || attachment.previewable?
    end
  end
end
