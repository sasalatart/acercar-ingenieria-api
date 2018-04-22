require_relative './seeds/announcements'
require_relative './seeds/users'
require_relative './seeds/questions'
require_relative './seeds/majors'
require_relative './seeds/admins'
require_relative './seeds/categories'
require_relative './seeds/articles'
require_relative './seeds/discussions'
require_relative './seeds/comments'
require_relative './seeds/credits'

options = {
  admins: {
    amount: 10,
    majors_amount: 3
  },
  users: {
    amount: 700
  },
  majors: {
    min_users_per: 5,
    max_users_per: 45
  },
  articles: {
    amount: 100,
    majors_proportion: 0.4,
    max_categories_per: 3
  },
  comments: {
    amount: 2000,
    max_children_per: 5,
    max_likes_per: 10
  },
  discussions: {
    amount: 100,
    max_likes_per: 25,
    max_tags_per: 3
  }
}

create_announcements!
create_users! options
create_questions!
create_majors! options
create_admins! options
create_categories!
create_articles! options
create_discussions! options
create_comments! options
create_credits!

puts('Done.')
