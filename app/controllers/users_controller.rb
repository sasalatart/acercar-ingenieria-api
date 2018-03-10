class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    paginated_json_response scoped_users
  end

  def show
    json_response @user
  end

  def update
    @user.update!(user_params)
    json_response @user
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private

  def scoped_users
    params[:major_id] ? Major.find(params[:major_id]).users : User.all
  end

  def user_params
    params.permit(:email,
                  :first_name,
                  :last_name,
                  :generation,
                  :bio,
                  :avatar,
                  major_users_attributes: %i[id major_id _destroy])
  end
end
