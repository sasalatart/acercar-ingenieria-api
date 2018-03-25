class AdminsController < ApplicationController
  before_action :authenticate_user!
  authorize_resource class: false

  before_action :set_user, only: %i[create destroy]

  def index
    paginated_json_response User.scoped_admins(params)
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
end
