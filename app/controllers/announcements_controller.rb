class AnnouncementsController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!
  before_action :set_announcement, only: %i[update destroy]

  def index
    paginated_json_response json: Announcement.all
  end

  def pinned
    json_response Announcement.pinned
  end

  def create
    @announcement = Announcement.create!(announcement_params)
    json_response(@announcement, :created)
  end

  def update
    @announcement.update!(announcement_params)
    json_response(@announcement, :ok)
  end

  def destroy
    @announcement.delete
    head :no_content
  end

  private

  def set_announcement
    @announcement = Announcement.find(params[:id])
  end

  def announcement_params
    params.permit(:text, :pinned, :picture)
  end
end
