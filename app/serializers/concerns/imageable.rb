module Imageable
  def image_hash(image, *sizes)
    return nil unless image.exists?
    sizes.map { |size| [size, image.url(size)] }.to_h
  end
end
