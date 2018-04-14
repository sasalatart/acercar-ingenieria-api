class DiscussionsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    paginated_json_response Discussion.scoped(params), each_serializer: DiscussionSerializer
  end

  def mine
    @discussions = Discussion.scoped(params.merge(author_id: current_user.id))
    paginated_json_response @discussions, each_serializer: DiscussionSerializer
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
    @discussion.update!(discussion_params)
    json_response @discussion
  end

  def destroy
    @discussion.destroy
    head :no_content
  end

  private

  def discussion_params
    permitted_params = [:title, :description, :tag_list,
                        attachments_attributes: %i[document id _destroy]]
    permitted_params.push(:pinned) if current_user.admin_of_something?
    params.permit(permitted_params)
  end
end
