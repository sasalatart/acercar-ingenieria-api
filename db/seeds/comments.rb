require_relative './likes'

def create_comments!(options)
  puts 'Creating comments...'

  all_users_ids = User.all.pluck(:id)
  all_commentables = Major.all + Article.all + Discussion.all

  options[:comments][:amount].times do
    comment = Comment.create!(author_id: all_users_ids.sample,
                              content: Faker::Lorem.paragraph(1, true, 8),
                              commentable: all_commentables.sample)

    likers_ids = all_users_ids.sample(rand(options[:comments][:max_likes_per]))
    add_likes_to(comment, likers_ids)
  end

  all_parent_comments = Comment.all
  all_parent_comments.each do |parent_comment|
    number_of_children = rand(options[:comments][:max_children_per])

    number_of_children.times do
      comment = Comment.create!(author_id: all_users_ids.sample,
                                content: Faker::Lorem.paragraph(1, true, 8),
                                commentable: parent_comment)

      likers_ids = all_users_ids.sample(rand(options[:comments][:max_likes_per]))
      add_likes_to(comment, likers_ids)
    end
  end
end
