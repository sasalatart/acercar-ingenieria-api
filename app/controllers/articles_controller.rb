class ArticlesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    paginated_json_response Article.scoped(params), each_serializer: ArticleSerializer
  end

  def show
    @article.read_notifications_from(current_user)
    json_response @article
  end

  def create
    @article = Article.create!(article_params.merge(author: current_user))
    json_response @article, status: :created
  end

  def update
    @article.purge_attachments(params[:destroyed_attachments])
    @article.update!(article_params)
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
                  :picture,
                  attachments: [])
  end

  def current_ability
    @current_ability ||= Abilities::ArticlesAbility.new(current_user, params)
  end
end
