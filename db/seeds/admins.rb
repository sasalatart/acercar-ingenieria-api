def create_admins!(options)
  puts 'Creating platform admins...'
  User.all.sample(options[:admins][:amount]).each(&:promote_to_admin)

  puts 'Creating major admins...'
  Major.all.each do |major|
    major.users.sample(options[:admins][:majors_amount]).each do |user|
      user.promote_to_admin major.id
    end
  end
end
