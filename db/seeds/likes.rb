def add_likes_to(likeable, user_ids)
  user_ids.each { |user_id| likeable.likes.create!(user_id: user_id) }
end
