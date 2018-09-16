class MajorSubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def subscribe
    current_user.majors << Major.find(params[:id])
    json_response current_user
  end

  def unsubscribe
    current_user.major_users.where(major_id: params[:id]).destroy_all
    json_response current_user
  end
end
