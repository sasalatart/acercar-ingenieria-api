class NotificationsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    paginated_json_response current_user.notifications.unseen
  end

  def seen
    paginated_json_response current_user.notifications.seen
  end

  def read
    @notification.update(seen: true)
    json_response @notification
  end

  def clear
    current_user.notifications.update_all(seen: true)
    head :no_content
  end
end
