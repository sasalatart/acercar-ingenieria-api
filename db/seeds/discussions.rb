require_relative './likes'

def create_discussions!(options)
  puts 'Creating discussions...'

  all_users_ids = User.all.pluck(:id)

  options[:discussions][:amount].times do |index|
    tag_list = Faker::Lorem.words(rand(options[:discussions][:max_tags_per]))
                           .join(', ')

    discussion = Discussion.create!(title: "#{index}-#{Faker::Lorem.sentence(5, true, 5)}",
                                    description: Faker::Lorem.paragraph,
                                    author_id: all_users_ids.sample,
                                    tag_list: tag_list)

    likers_ids = all_users_ids.sample(rand(options[:discussions][:max_likes_per]))
    add_likes_to(discussion, likers_ids)
  end
end
