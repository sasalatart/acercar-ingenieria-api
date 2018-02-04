require_relative './likes'

def create_comments!(options)
  puts 'Creating comments...'

  all_users_ids = User.all.pluck(:id)
  all_commentables = Major.all + Article.all + Discussion.all

  options[:comments][:amount].times do
    comment = Comment.create!(author_id: all_users_ids.sample,
                              content: Faker::Lorem.paragraph,
                              commentable: all_commentables.sample)

    likers_ids = all_users_ids.sample(rand(options[:comments][:max_likes_per]))
    add_likes_to(comment, likers_ids)
  end

  all_parent_comments = Comment.all
  all_parent_comments.each do |parent_comment|
    comment = Comment.create!(author_id: all_users_ids.sample,
                              content: Faker::Lorem.paragraph,
                              commentable: parent_comment.commentable,
                              parent_comment: parent_comment)

    likers_ids = all_users_ids.sample(rand(options[:comments][:max_likes_per]))
    add_likes_to(comment, likers_ids)
  end
end
