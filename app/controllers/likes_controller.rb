class LikesController < ApplicationController
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

  private

  def find_likeable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return Regexp.last_match(1).classify.constantize.find(value)
      end
    end

    nil
  end
end
