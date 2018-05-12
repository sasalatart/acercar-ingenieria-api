class MajorsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  load_and_authorize_resource

  def index
    json_response Major.all.order(name: :asc), each_serializer: MajorSerializer
  end

  def show
    json_response @major
  end

  def create
    @major = Major.create!(major_params)
    json_response @major, status: :created
  end

  def update
    @major.update!(major_params)
    json_response @major
  end

  def destroy
    @major.destroy
    head :no_content
  end

  def email
    contact(@major.users.pluck(:email))
    head :no_content
  end

  def personal_email
    contact(@major.admins.pluck(:email))
    head :no_content
  end

  private

  def contact(to_emails)
    MajorMailer.contact(
      current_user.email,
      to_emails - [current_user.email],
      Sanitize.fragment(params[:subject], Sanitize::Config::RELAXED),
      Sanitize.fragment(params[:body], Sanitize::Config::RELAXED)
    ).deliver
  end

  def major_params
    params.permit(:name,
                  :category,
                  :short_description,
                  :description,
                  :video_url,
                  :logo)
  end

  def current_ability
    @current_ability ||= Abilities::MajorsAbility.new(current_user, params)
  end
end
