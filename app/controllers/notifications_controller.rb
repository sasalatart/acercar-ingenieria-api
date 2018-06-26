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

  def count
    json_response count: current_user.notifications.unseen.count
  end

  def set_all_as_seen
    current_user.set_all_notifications_as_seen
    head :no_content
  end

  private

  def current_ability
    @current_ability ||= Abilities::NotificationsAbility.new(current_user, params)
  end
end
