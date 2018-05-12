source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.2'
gem 'bootsnap', require: false
gem 'pg', '~> 0.18'
gem 'pg_search'
gem 'puma', '~> 3.7'

gem 'redis', '~> 3.0'
gem 'sidekiq'

gem 'pusher'

gem 'rails-i18n', '~> 5.1'
gem 'devise-i18n'

gem 'devise_token_auth'
gem 'cancancan', '~> 2.0'
gem 'rolify'

gem 'kaminari'
gem 'api-pagination'
gem 'active_model_serializers', '~> 0.10.0'

gem 'acts-as-taggable-on', git: 'git://github.com/Fodoj/acts-as-taggable-on.git', ref: 'b0e734b'
gem 'impressionist'

gem 'mailgun_rails'

gem 'exception_notification'

gem 'mini_magick'
gem 'aws-sdk-s3'

gem 'sanitize', '~> 4.6.3'

gem 'faker'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', '0.4.1', :require => 'rack/cors'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'annotate'
  gem 'lol_dba'
  gem 'bullet'
  gem 'hirb'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
