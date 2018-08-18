Devise.setup do |config|
  config.secret_key = Rails.application.credentials.secret_key_base
  config.mailer_sender = 'do-not-reply@acercaringenieria.cl'
  config.navigational_formats = [:json]
end
