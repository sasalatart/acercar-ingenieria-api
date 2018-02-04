def create_uploaded_image(dir, name, extension = 'jpg')
  path = "#{Rails.root}/db/seeds/assets/#{dir}/#{name}.#{extension}"
  image_file = File.new(path)
  type = MIME::Types.type_for(path).first.content_type

  ActionDispatch::Http::UploadedFile.new(filename: File.basename(image_file),
                                         tempfile: image_file,
                                         type: type)
end
