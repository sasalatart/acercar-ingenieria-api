class MajorsController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!
  before_action :set_major, only: %i[show update destroy]

  def index
    paginate json: User.all
  end

  def show
    render json: @major
  end

  def create
    @major = Major.create!(major_params)
    json_response(@major, :created)
  end

  def update
    @major.update!(major_params)
    json_response(@major, :ok)
  end

  def destroy
    @major.delete
    head :no_content
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
