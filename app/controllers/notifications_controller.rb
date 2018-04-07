class NotificationsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @notifications = current_user.notifications.unseen.order(created_at: :desc)
    paginated_json_response @notifications, each_serializer: NotificationSerializer
  end

  def seen
    @notifications = current_user.notifications.seen.order(created_at: :desc)
    paginated_json_response @notifications, each_serializer: NotificationSerializer
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
