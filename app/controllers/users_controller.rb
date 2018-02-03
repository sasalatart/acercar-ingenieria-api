class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    paginated_json_response User.all
  end

  def show
    json_response @user
  end

  def update
    @user.update!(user_params)
    json_response @user
  end

  def active
    @user.toggle! :active
    sign_out @user unless @user.active?
    json_response @user
  end

  private

  def user_params
    params.require(:user)
          .permit(:email,
                  :first_name,
                  :last_name,
                  :generation,
                  major_users_attributes: %i[id major_id _destroy])
  end
end
