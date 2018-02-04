def create_categories!
  puts 'Creating categories...'

  %w[Investigaciones Alumnos Profesores Ex-Alumnos Industria Otros].map do |name|
    Category.create!(name: name)
  end
end
