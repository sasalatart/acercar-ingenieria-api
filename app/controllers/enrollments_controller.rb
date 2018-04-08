class EnrollmentsController < ApplicationController
  include ActAsPolymorphic

  before_action :authenticate_user!
  load_and_authorize_resource

  def create
    @enrollment = find_enrollable.enroll!(current_user)
    json_response @enrollment, status: :created
  end

  def destroy
    find_enrollable.unenroll!(current_user)
    head :no_content
  end
end
