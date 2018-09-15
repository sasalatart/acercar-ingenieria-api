module Abilities
  class QuestionsAbility < BaseAbility
    def initialize(user, params)
      super(user, params)

      unless @majors_user_is_admin.empty?
        can %i[unanswered], Question if @majors_user_is_admin.include? params[:major_id].to_i
        can %i[update destroy], Question, major_id: @majors_user_is_admin
      end

      unless @user.new_record?
        can %i[create], Question
        can %i[update destroy], Question, author_id: @user.id
      end

      can %i[index], Question
    end
  end
end
