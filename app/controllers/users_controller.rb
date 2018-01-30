class UsersController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!
  before_action :set_user, only: %i[show active]

  def index
    paginated_json_response User.all
  end

  def admins
    paginated_json_response User.with_role :admin
  end

  def show
    json_response @user
  end

  def update
    @user.update!(user_params)
    json_response @user
  end

  def admin
    @user.toggle_admin
    json_response @user
  end

  def active
    @user.toggle! :active
    sign_out @user unless @user.active?
    json_response @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user)
          .permit(:email,
                  :first_name,
                  :last_name,
                  :generation,
                  major_users_attributes: %i[id major_id _destroy])
  end
end
