class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  load_and_authorize_resource

  def index
    @questions = scoped_questions.answered.order(pinned: :desc)
    paginated_json_response @questions, each_serializer: QuestionSerializer
  end

  def pending
    @questions = scoped_questions.not_answered
    paginated_json_response @questions, each_serializer: QuestionSerializer
  end

  def create
    @question = Question.create!(question_params.merge(author: current_user))
    json_response @question, status: :created
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
    params.permit(:id, :question, :answer, :pinned, :major_id)
  end

  def student_question_params
    params.permit(:id, :question, :major_id)
  end
end
