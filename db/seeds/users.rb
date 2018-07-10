def create_main_admin!
  puts 'Creating main admin...'
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
end

def create_random_user!(index, options)
  user = User.new(
    email: "user-#{index}@uc.cl",
    password: 'napoleon',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    generation: rand(2011..2018),
    bio: Faker::Lorem.sentence,
    tokens: nil
  )
  user.skip_confirmation!
  user.save!

  user.majors << Major.all.sample(rand(options[:max_majors] + 1))
end

def create_random_users!(options)
  puts 'Creating random users...'
  options[:amount].times { |index| create_random_user!(index, options) }
  User.update_all(tokens: nil)
end
