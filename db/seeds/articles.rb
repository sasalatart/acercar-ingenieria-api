def create_articles!(options)
  puts 'Creating articles...'

  all_majors = Major.all

  options[:articles][:amount].times do |index|
    major = rand <= options[:articles][:majors_proportion] ? all_majors.sample : nil
    author = major ? User.with_role(:major_admin, major).sample : User.with_role(:admin).sample

    category_list = Category.all
                            .sample(options[:articles][:max_categories_per])
                            .pluck(:name)
                            .join(', ')

    Article.create!(major: major,
                    title: "#{index}-#{Faker::Lorem.sentence(2)}",
                    short_description: Faker::Lorem.paragraph,
                    content: Faker::Lorem.paragraph,
                    author: author,
                    category_list: category_list)
  end
end
