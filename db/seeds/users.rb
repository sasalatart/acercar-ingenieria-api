def create_random_user!(index)
  user = User.new(
    email: "user-#{index}@uc.cl",
    password: 'napoleon',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    generation: rand(2011..2017),
    bio: Faker::Lorem.sentence
  )
  user.skip_confirmation!
  user.save!
end

def create_users!(options)
  puts 'Creating users...'

  admin = User.new(
    email: 'acercaringenieria@uc.cl',
    password: 'napoleon',
    first_name: 'Admin',
    last_name: 'AI',
    generation: 2011
  )
  admin.skip_confirmation!
  admin.save!
  admin.promote_to_admin

  options[:amount].times { |index| create_random_user!(index) }
  User.update_all(tokens: nil)
end
