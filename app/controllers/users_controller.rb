class UsersController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!
  before_action :set_user, only: %i[show activate deactivate]

  def index
    paginated_json_response User.all
  end

  def show
    json_response @user
  end

  def activate
    @user.toggle_active(true)
    json_response @user
  end

  def deactivate
    @user.toggle_active(false)
    sign_out @user
    json_response @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
