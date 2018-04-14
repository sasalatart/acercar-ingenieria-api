require 'sidekiq'
require 'sidekiq/web'

sidekiq_config = { url: ENV['JOB_WORKER_URL'] }

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  user == Rails.application.secrets.sidekiq_username &&
    password == Rails.application.secrets.sidekiq_password
end
