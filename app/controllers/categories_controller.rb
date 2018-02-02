class CategoriesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

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
    @category.destroy
    head :no_content
  end

  private

  def category_params
    params.permit(:name)
  end
end
