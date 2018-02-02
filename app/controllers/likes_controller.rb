class LikesController < ApplicationController
  include ActAsPolymorphic

  before_action :authenticate_user!
  load_and_authorize_resource

  def create
    @like = Like.create!(user: current_user, likeable: find_likeable)
    json_response @like, :created
  end

  def destroy
    @like.destroy
    head :no_content
  end
end
