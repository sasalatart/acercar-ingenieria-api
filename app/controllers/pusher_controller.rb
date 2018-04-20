class PusherController < ApplicationController
  before_action :authenticate_user!

  def auth
    if current_user.id == params[:channel_name].split('-').last.to_i
      response = Pusher.authenticate(params[:channel_name], params[:socket_id])
      render json: response
    else
      raise CanCan::AccessDenied
    end
  end
end
