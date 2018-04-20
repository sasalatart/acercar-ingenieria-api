require 'pusher'

secrets = Rails.application.secrets

Pusher.app_id     = secrets[:pusher_app_id]
Pusher.key        = secrets[:pusher_key]
Pusher.secret     = secrets[:pusher_secret]
Pusher.cluster    = secrets[:pusher_cluster]
Pusher.logger     = Rails.logger
Pusher.encrypted  = true
