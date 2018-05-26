class ArticlesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    paginated_response Article.scoped(params).approved
  end

  def mine
    paginated_response Article.scoped(params.merge(author_id: current_user.id))
  end

  def pending
    paginated_response Article.scoped(params).pending
  end

  def show
    @article.read_notifications_from(current_user)
    json_response @article
  end

  def create
    @article = Article.create!(article_params.merge(extra_params))
    json_response @article, status: :created
  end

  def update
    @article.purge_attachments(params[:destroyed_attachments])
    @article.update!(article_params.merge(extra_params))
    json_response @article
  end

  def approval
    @article.update_approval(params[:approved], current_user)
    json_response @article
  end

  def destroy
    @article.destroy
    head :no_content
  end

  private

  def article_params
    params.permit(:id,
                  :title,
                  :short_description,
                  :content,
                  :major_id,
                  :category_list,
                  :preview,
                  attachments: [])
  end

  def paginated_response(articles)
    paginated_json_response articles, each_serializer: ArticleSummarySerializer
  end

  def extra_params
    { author: current_user, approved: current_user.admin?(params[:major_id]) }
  end

  def current_ability
    @current_ability ||= Abilities::ArticlesAbility.new(current_user, params)
  end
end
