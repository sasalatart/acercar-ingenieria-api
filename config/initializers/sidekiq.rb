require 'sidekiq'
require 'sidekiq/web'

redis_host = Rails.env.development? || Rails.env.test? ? 'localhost' : 'redis'
sidekiq_config = { url: "redis://#{redis_host}:6379/0" }

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  user == Rails.application.credentials[:sidekiq][:username] &&
    password == Rails.application.credentials[:sidekiq][:password]
end
