require_relative './likes'

def commentable_meta_from(models)
  models.map do |model|
    model.all.pluck(:id).map { |id| { id: id, type: model.name } }
  end.flatten
end

def create_random_comment!(all_user_ids, commentable, max_likes_per)
  commentable_type, commentable_id = commentable.values_at(:type, :id)

  comment = Comment.create!(
    author_id: all_user_ids.sample,
    content: Faker::Lorem.paragraph(1, true, 8),
    commentable_type: commentable_type,
    commentable_id: commentable_id
  )

  likers_ids = all_user_ids.sample(rand(max_likes_per))
  add_likes_to(comment, likers_ids)
end

def create_random_comments!(options)
  puts 'Creating comments...'

  all_user_ids = User.all.pluck(:id)
  all_commentables = commentable_meta_from([Major, Article, Discussion])

  options[:amount].times do
    create_random_comment!(all_user_ids, all_commentables.sample, options[:max_likes_per])
  end

  parent_commentables = commentable_meta_from([Comment])
  parent_commentables.each do |commentable|
    number_of_children = rand(options[:max_children_per])
    number_of_children.times do
      create_random_comment!(all_user_ids, commentable, options[:max_likes_per])
    end
  end
end
