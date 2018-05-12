module StorableSerializer
  include Rails.application.routes.url_helpers

  def default_url_options
    DEFAULT_URL_OPTIONS
  end
end
