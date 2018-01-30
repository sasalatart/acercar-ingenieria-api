class MajorsController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!
  before_action :set_major, only: %i[show update destroy, articles]

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
    @major.delete
    head :no_content
  end

  def articles
    paginated_json_response @major.articles
  end

  private

  def set_major
    @major = Major.find(params[:id])
  end

  def major_params
    params.permit(:name,
                  :category,
                  :description,
                  :video_url_code,
                  :logo)
  end
end
