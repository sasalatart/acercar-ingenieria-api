class CommentsController < ApplicationController
  include ActAsPolymorphic

  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    paginated_json_response find_commentable.comments.primary
  end

  def create
    parameters = creation_params.merge(author: current_user,
                                       commentable: find_commentable)
    @comment = Comment.create!(parameters)
    json_response @comment, :created
  end

  def update
    @comment.update!(update_params)
    json_response @comment
  end

  def destroy
    @comment.destroy
    head :no_content
  end

  private

  def creation_params
    params.permit(:content, :parent_comment_id)
  end

  def update_params
    params.permit(:id, :content)
  end
end
