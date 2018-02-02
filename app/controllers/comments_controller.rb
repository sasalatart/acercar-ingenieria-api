class CommentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def create
    @comment = Comment.new(creation_params)
    @comment.author = current_user
    @comment.save!
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
    params.permit(:id,
                  :content,
                  :parent_comment_id,
                  :commentable_id,
                  :commentable_type)
  end

  def update_params
    params.permit(:id, :content)
  end
end
