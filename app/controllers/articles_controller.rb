class ArticlesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    paginated_json_response scoped_articles
  end

  def show
    json_response @article
  end

  def create
    @article = Article.create!(article_params.merge(author: current_user))
    json_response @article, :created
  end

  def update
    @article.update!(article_params)
    json_response @article
  end

  def destroy
    @article.destroy
    head :no_content
  end

  private

  def scoped_articles
    categories = params[:category_list]
    @articles = categories ? Article.tagged_with(categories) : Article.all
    @articles = @articles.of_major(params[:major_id]) if params[:major_id]
    @articles
  end

  def article_params
    params.permit(:id,
                  :title,
                  :short_description,
                  :content,
                  :major_id,
                  :category_list,
                  :picture,
                  attachments_attributes: [:content])
  end
end
