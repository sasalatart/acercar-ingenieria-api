class VideoLinksController < ApplicationController
  include ActAsPolymorphic

  before_action :authenticate_user!, except: :index
  before_action :set_video_linkable, only: %i[index create]
  load_and_authorize_resource

  def index
    @video_links = @video_linkable.video_links.order([pinned: :desc, created_at: :desc])
    paginated_json_response @video_links
  end

  def create
    creation_params = video_link_params.merge(video_linkable: @video_linkable)
    @video_link = VideoLink.create!(creation_params)
    json_response @video_link, status: :created
  end

  def update
    @video_link.update!(video_link_params)
    json_response @video_link
  end

  def destroy
    @video_link.destroy
    head :no_content
  end

  private

  def set_video_linkable
    @video_linkable = find_video_linkable
  end

  def video_link_params
    params.permit(:title, :url, :pinned)
  end
end
