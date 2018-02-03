class MajorsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show questions]
  load_and_authorize_resource

  def index
    paginated_json_response Major.all
  end

  def show
    json_response @major
  end

  def create
    @major = Major.create!(major_params)
    json_response @major, :created
  end

  def update
    @major.update!(major_params)
    json_response @major
  end

  def destroy
    @major.destroy
    head :no_content
  end

  def users
    paginated_json_response @major.users
  end

  def admins
    paginated_json_response User.with_role :major_admin, @major
  end

  def articles
    paginated_json_response @major.articles
  end

  def admin
    @major.toggle_admin params[:user_id]
    json_response @major
  end

  private

  def major_params
    params.permit(:name,
                  :category,
                  :description,
                  :video_url_code,
                  :logo)
  end
end
