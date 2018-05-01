class CreditsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  load_and_authorize_resource

  def index
    json_response Credit.all
  end

  def create
    @credit = Credit.create!(credit_params)
    json_response @credit, status: :created
  end

  def update
    @credit.update!(credit_params)
    json_response @credit
  end

  def destroy
    @credit.destroy
    head :no_content
  end

  private

  def credit_params
    params.permit(:resource_name,
                  :resource_url,
                  :author_name,
                  :resource)
  end

  def current_ability
    @current_ability ||= Abilities::CreditsAbility.new(current_user, params)
  end
end
