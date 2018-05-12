def add_uploaded_image(instance, attribute_name, dir, name, extension = 'jpg')
  path = "#{Rails.root}/db/seeds/assets/#{dir}/#{name}.#{extension}"
  instance.send(attribute_name)
          .attach(io: File.open(path), filename: "#{name}.#{extension}")
end
