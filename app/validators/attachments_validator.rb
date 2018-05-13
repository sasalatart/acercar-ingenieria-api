class AttachmentsValidator < ActiveModel::EachValidator
  def media_type?(attachment)
    extra_types = %w(application/pdf application/x-rar-compressed application/zip)

    attachment.text? ||
      attachment.image? ||
      attachment.video? ||
      attachment.audio? ||
      attachment.content_type.in?(extra_types)
  end

  def validate_each(record, attribute, value)
    return unless value.attached?

    max_amount, max_total_size = options.values_at(:max_amount, :max_total_size)
    all_attachments = record.attachments

    max_count_reached = all_attachments.count > max_amount

    max_size_reached = all_attachments.reduce(0) do |acc, attachment|
      acc + attachment.blob.byte_size
    end > max_total_size

    not_media = !value.reduce(true) { |acc, attachment| acc && media_type?(attachment) }

    return unless max_count_reached || max_size_reached || not_media

    max_size_mb = max_total_size / 1.megabyte

    record.errors.add attribute, :max_count_reached, count: max_amount if max_count_reached
    record.errors.add attribute, :max_size_reached, size: max_size_mb if max_size_reached
    record.errors.add attribute, :not_media if not_media
    value.destroy_all
  end
end
