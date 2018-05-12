class ImageValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    required, max_size = options.values_at(:required, :max_size)

    return if !required && !value.attached?

    if required && !value.attached?
      record.errors.add attribute, :required
      return
    end

    not_an_image = !value.image?
    max_size_reached = value.blob.byte_size >= max_size

    return unless not_an_image || max_size_reached

    max_size_mb = max_size / 1.megabyte

    record.errors.add attribute, :not_an_image if not_an_image
    record.errors.add attribute, :max_size_reached, size: max_size_mb if max_size_reached
    value.purge
  end
end
