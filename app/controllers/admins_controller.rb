class AdminsController < ApplicationController
  before_action :authenticate_user!
  authorize_resource class: false

  before_action :set_user, only: %i[create destroy]

  def index
    paginated_json_response scoped_admins
  end

  def create
    json_response @user.promote_to_admin params[:major_id]
  end

  def destroy
    json_response @user.demote_from_admin params[:major_id]
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def scoped_admins
    return User.with_role(:admin) unless params[:major_id]
    User.with_role :major_admin, Major.find(params[:major_id])
  end
end
