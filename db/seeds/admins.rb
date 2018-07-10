def create_random_admins!(options)
  puts 'Creating platform admins...'
  User.all.sample(options[:amount]).each(&:promote_to_admin)

  puts 'Creating major admins...'
  Major.all.each do |major|
    major.users.sample(options[:majors_amount]).each do |user|
      user.promote_to_admin major.id
    end
  end
end
