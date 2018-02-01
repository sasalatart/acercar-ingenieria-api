class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  load_and_authorize_resource

  def index
    paginated_json_response Question.not_of_major.answered
  end

  def pending
    paginated_json_response Question.not_of_major.not_answered
  end

  def create
    @question = Question.new(question_params)
    @question.author = current_user
    @question.save!
    json_response @question, :created
  end

  def update
    @question.update!(question_params)
    json_response @question
  end

  def destroy
    @question.delete
    head :no_content
  end

  private

  def question_params
    user_admin = Major.user_admin?(current_user, params[:major_id])
    user_admin ? admin_question_params : student_question_params
  end

  def admin_question_params
    params.permit(:id, :question, :answer, :major_id)
  end

  def student_question_params
    params.permit(:id, :question, :major_id)
  end
end
