class CommentsController < ApplicationController
  include ActAsPolymorphic

  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    paginated_json_response find_commentable.comments
      .primary
      .order(created_at: :desc)
  end

  def create
    parameters = comment_params.merge(author: current_user,
                                      commentable: find_commentable)
    @comment = Comment.create!(parameters)
    json_response @comment, :created, @comment.serializer
  end

  def update
    @comment.update!(comment_params)
    json_response @comment, :ok, @comment.serializer
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
