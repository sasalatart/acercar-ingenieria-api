class MajorsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
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

  private

  def major_params
    params.permit(:name,
                  :category,
                  :description,
                  :video_url_code,
                  :logo)
  end
end
