class AnnouncementsController < ApplicationController
  before_action :authenticate_user!, except: [:pinned]
  load_and_authorize_resource

  def index
    paginated_json_response Announcement.all
  end

  def pinned
    json_response Announcement.pinned
  end

  def create
    @announcement = Announcement.create!(announcement_params)
    json_response @announcement, :created
  end

  def update
    @announcement.update!(announcement_params)
    json_response @announcement
  end

  def destroy
    @announcement.destroy
    head :no_content
  end

  private

  def announcement_params
    params.permit(:text, :pinned, :picture)
  end
end
