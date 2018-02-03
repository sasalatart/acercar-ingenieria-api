class AdminsController < ApplicationController
  before_action :authenticate_user!
  authorize_resource class: false

  def index
    paginated_json_response scoped_admins
  end

  def toggle
    @user = User.find(params[:id])
    json_response @user.toggle_admin params[:major_id]
  end

  private

  def scoped_admins
    return User.with_role(:admin) unless params[:major_id]
    User.with_role :major_admin, Major.find(params[:major_id])
  end
end
