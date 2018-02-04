def create_users!(options)
  puts 'Creating users...'

  admin = User.new(email: 'acercaringenieria@uc.cl',
                   password: 'napoleon',
                   first_name: 'Admin',
                   last_name: 'AI',
                   generation: 2011)
  admin.skip_confirmation!
  admin.save!
  admin.toggle_admin

  options[:users][:amount].times do |i|
    user = User.new(email: "example-user-#{i}@uc.cl",
                    password: 'napoleon',
                    first_name: Faker::Name.first_name,
                    last_name: Faker::Name.last_name,
                    generation: rand(2011..2017),
                    bio: Faker::Lorem.sentence)
    user.skip_confirmation!
    user.save!
  end
end
