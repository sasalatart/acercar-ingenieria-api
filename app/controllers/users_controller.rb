class UsersController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!
  before_action :set_user, only: %i[show activate deactivate]

  def index
    render json: User.all
  end

  def show
    render json: @user
  end

  def activate
    @user.toggle_active(true)
    render json: @user
  end

  def deactivate
    @user.toggle_active(false)
    sign_out @user
    render json: @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
