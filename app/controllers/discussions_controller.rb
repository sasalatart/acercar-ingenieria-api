class DiscussionsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    paginated_response Discussion.scoped(params)
  end

  def mine
    paginated_response Discussion.scoped(params.merge(author_id: current_user.id))
  end

  def show
    @discussion.read_notifications_from(current_user)
    impressionist @discussion
    json_response @discussion
  end

  def create
    creation_params = discussion_params.merge(author: current_user)
    @discussion = Discussion.create!(creation_params)
    json_response @discussion, status: :created
  end

  def update
    @discussion.purge_attachments(params[:destroyed_attachments])
    @discussion.update!(discussion_params)
    json_response @discussion
  end

  def destroy
    @discussion.destroy
    head :no_content
  end

  private

  def discussion_params
    permitted_params = [:title, :description, :tag_list, attachments: []]
    permitted_params.push(:pinned) if current_user.admin_of_something?
    params.permit(permitted_params)
  end

  def paginated_response(discussions)
    paginated_json_response discussions, each_serializer: DiscussionSummarySerializer
  end

  def current_ability
    @current_ability ||= Abilities::DiscussionsAbility.new(current_user, params)
  end
end
