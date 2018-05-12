module ImageableSerializer
  include StorableSerializer

  SIZES = { thumb: '75x75', medium: '200x200', large: '1440x880' }.freeze

  def image_hash(image, *sizes)
    return nil unless image.attached?

    sizes.map do |size|
      [size, rails_representation_url(image.variant(resize: SIZES[size]))]
    end.to_h
  end
end
