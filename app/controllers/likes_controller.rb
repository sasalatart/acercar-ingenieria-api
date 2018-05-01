class LikesController < ApplicationController
  include ActAsPolymorphic

  before_action :authenticate_user!
  load_and_authorize_resource

  def create
    @like = Like.create!(user: current_user, likeable: find_likeable)
    json_response @like, status: :created
  end

  def destroy
    find_likeable.likes.where(user: current_user).destroy_all
    head :no_content
  end

  private

  def current_ability
    @current_ability ||= Abilities::LikesAbility.new(current_user, params)
  end
end
