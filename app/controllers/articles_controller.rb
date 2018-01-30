class ArticlesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

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
    @article.delete
    head :no_content
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
