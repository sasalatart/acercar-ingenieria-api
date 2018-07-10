require_relative './seeds/users'
require_relative './seeds/announcements'
require_relative './seeds/questions'
require_relative './seeds/majors'
require_relative './seeds/categories'
require_relative './seeds/credits'
require_relative './seeds/admins'
require_relative './seeds/articles'
require_relative './seeds/discussions'
require_relative './seeds/comments'

options = {
  admins: {
    amount: 10,
    majors_amount: 3
  },
  users: {
    amount: 700,
    max_majors: 3
  },
  articles: {
    amount: 100,
    majors_proportion: 0.4,
    max_categories_per: 3,
    max_likes_per: 10,
    approved_proportion: 0.9
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

create_main_admin!
create_announcements!
create_questions!
create_majors!
create_categories!
create_credits!

if ENV['EXTENDED']
  create_random_users! options[:users]
  create_random_admins! options[:admins]
  create_random_articles! options[:articles]
  create_random_discussions! options[:discussions]
  create_random_comments! options[:comments]
  reject_random_articles options[:articles]
end

puts('Done.')
