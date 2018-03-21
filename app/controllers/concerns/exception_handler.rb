module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, status: :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: e.message }, status: :unprocessable_entity)
    end

    rescue_from CanCan::AccessDenied do |e|
      json_response({ message: e.message }, status: :unauthorized)
    end
  end
end
