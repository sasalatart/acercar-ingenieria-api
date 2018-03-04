class CommentsController < ApplicationController
  include ActAsPolymorphic

  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @comments = find_commentable.comments.primary.order(created_at: :desc)
    paginated_json_response @comments, each_serializer: CommentSerializer
  end

  def create
    automatic_params = { author: current_user, commentable: find_commentable }
    @comment = Comment.create!(comment_params.merge(automatic_params))
    json_response @comment, status: :created, serializer: @comment.serializer
  end

  def update
    @comment.update!(comment_params)
    json_response @comment, serializer: @comment.serializer
  end

  def destroy
    @comment.destroy
    head :no_content
  end

  private

  def comment_params
    return params.permit(:content) if params[:id]
    params.permit(:content, :parent_comment_id)
  end
end
