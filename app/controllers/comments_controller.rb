class CommentsController < ApplicationController
  include ActAsPolymorphic

  before_action :authenticate_user!
  before_action :set_commentable, only: %i[index create]
  load_and_authorize_resource

  def index
    @comments = @commentable.comments.order(created_at: order)
    Comment.read_notifications_from(current_user, @comments.pluck(:id))
    paginated_json_response @comments, per_page: 15, each_serializer: CommentSerializer
  end

  def show
    @comment.read_notifications_from(current_user)
    json_response @comment, serializer: @comment.serializer
  end

  def create
    automatic_params = { author: current_user, commentable: @commentable }
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
    params.permit(:content)
  end

  def set_commentable
    @commentable = find_commentable
  end

  def order
    @commentable.respond_to?(:child_comments) ? :asc : :desc
  end

  def current_ability
    @current_ability ||= Abilities::CommentsAbility.new(current_user, params)
  end
end
