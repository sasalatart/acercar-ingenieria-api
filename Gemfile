source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'pg', '~> 0.18'
gem 'pg_search'
gem 'puma', '~> 3.7'

gem 'rails-i18n', '~> 5.1'
gem 'devise-i18n'

gem 'devise_token_auth'
gem 'cancancan', '~> 2.0'
gem 'rolify'

gem 'kaminari'
gem 'api-pagination'
gem 'active_model_serializers', '~> 0.10.0'

gem 'acts-as-taggable-on', '~> 5.0'
gem 'impressionist'

gem 'mailgun_rails'

gem 'paperclip', '~> 5.0.0'
gem 'paperclip-cloudinary'

gem 'sanitize'

gem 'faker'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', '0.4.1', :require => 'rack/cors'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'annotate'
  gem 'bullet'
  gem 'hirb'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
