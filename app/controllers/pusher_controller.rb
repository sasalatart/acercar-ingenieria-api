class PusherController < ApplicationController
  before_action :authenticate_user!

  def auth
    authorize_pusher!

    response = Pusher.authenticate(params[:channel_name], params[:socket_id])
    render json: response
  end

  private

  def authorize_pusher!
    return if current_user.id == params[:channel_name].split('-').last.to_i
    raise CanCan::AccessDenied
  end
end
