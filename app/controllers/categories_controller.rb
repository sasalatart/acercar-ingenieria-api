class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: :index
  load_and_authorize_resource

  def index
    json_response Category.all
  end

  def create
    @category = Category.create!(category_params)
    json_response @category, status: :created
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

  def current_ability
    @current_ability ||= Abilities::CategoriesAbility.new(current_user, params)
  end
end
