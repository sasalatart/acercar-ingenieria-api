module Abilities
  class ArticlesAbility < BaseAbility
    def initialize(user, params)
      super(user, params)

      return if @user.new_record?

      unless @majors_user_is_admin.empty?
        can %i[update destroy], Article, major_id: @majors_user_is_admin
      end

      can %i[index show create], Article
      can %i[update destroy], Article, author_id: @user.id
    end
  end
end
