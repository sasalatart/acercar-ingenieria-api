class CategoriesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def index
    paginated_json_response Category.all
  end

  def create
    @category = Category.create!(category_params)
    json_response @category, :created
  end

  def update
    @category.update!(category_params)
    json_response @category
  end

  def destroy
    @category.delete
    head :no_content
  end

  private

  def category_params
    params.permit(:name)
  end
end
