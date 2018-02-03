class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  load_and_authorize_resource

  def index
    paginated_json_response scoped_questions.answered
  end

  def pending
    paginated_json_response scoped_questions.not_answered
  end

  def create
    @question = Question.create!(question_params.merge(author: current_user))
    json_response @question, :created
  end

  def update
    @question.update!(question_params.except(:major_id))
    json_response @question
  end

  def destroy
    @question.destroy
    head :no_content
  end

  private

  def scoped_questions
    params[:major_id] ? Question.of_major(params[:major_id]) : Question.general
  end

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
