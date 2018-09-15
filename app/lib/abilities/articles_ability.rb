module Abilities
  class ArticlesAbility < BaseAbility
    def initialize(user, params)
      super(user, params)

      return if @user.new_record?

      unless @majors_user_is_admin.empty?
        can %i[unapproved], Article if @majors_user_is_admin.include? params[:major_id].to_i
        can %i[show update approval destroy], Article, major_id: @majors_user_is_admin
      end

      can %i[index mine create], Article
      can %i[show], Article, approved: true
      can %i[show update destroy], Article, author_id: @user.id
    end
  end
end
