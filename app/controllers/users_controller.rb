class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    paginated_json_response User.scoped(params), each_serializer: UserSerializer
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

  def user_params
    params.permit(:email,
                  :first_name,
                  :last_name,
                  :generation,
                  :bio,
                  :avatar,
                  major_users_attributes: %i[id major_id _destroy])
  end

  def current_ability
    @current_ability ||= Abilities::UsersAbility.new(current_user, params)
  end
end
