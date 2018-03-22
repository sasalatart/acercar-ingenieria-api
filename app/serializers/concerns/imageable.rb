module Imageable
  def image_hash(image, *sizes)
    return nil unless image.original_filename
    sizes.map { |size| [size, image.url(size)] }.to_h
  end
end
