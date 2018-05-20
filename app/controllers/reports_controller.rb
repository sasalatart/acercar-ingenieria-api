class ReportsController < ApplicationController
  include ActAsPolymorphic

  before_action :authenticate_user!

  def report
    find_reportable.report(current_user.email, params[:body], params[:resource_url])
    head :no_content
  end
end
