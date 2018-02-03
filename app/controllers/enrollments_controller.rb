class EnrollmentsController < ApplicationController
  include ActAsPolymorphic

  before_action :authenticate_user!
  load_and_authorize_resource

  def create
    @enrollment = find_enrollable.enroll!(current_user)
    json_response @enrollment, :created
  end

  def destroy
    @enrollment.destroy
    head :no_content
  end
end
