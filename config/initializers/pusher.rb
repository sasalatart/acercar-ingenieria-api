require 'pusher'

pusher_credentials = Rails.application.credentials[:pusher]

Pusher.app_id     = pusher_credentials[:app_id]
Pusher.key        = pusher_credentials[:key]
Pusher.secret     = pusher_credentials[:secret]
Pusher.cluster    = pusher_credentials[:cluster]
Pusher.logger     = Rails.logger
Pusher.encrypted  = true
