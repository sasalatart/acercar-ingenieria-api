class ArticlesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    paginated_json_response Article.find_by_categories params[:category_ids]
  end

  def show
    json_response @article
  end

  def create
    @article = Article.create!(article_params)
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

  def comments
    paginated_json_response @article.comments.primary
  end

  private

  def article_params
    params.permit(:id,
                  :title,
                  :short_description,
                  :content,
                  :major_id,
                  article_categories_attributes: %i[id category_id _destroy],
                  attachments_attributes: [:content])
  end
end
