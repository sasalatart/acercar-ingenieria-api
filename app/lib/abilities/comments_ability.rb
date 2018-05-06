module Abilities
  class CommentsAbility < BaseAbility
    def initialize(user, params)
      super(user, params)

      return if @user.new_record?

      unless @majors_user_is_admin.empty?
        can %i[destroy], Comment, commentable_type: Major.name, commentable_id: @majors_user_is_admin
      end

      can %i[index show create], Comment
      can %i[update destroy], Comment, author_id: @user.id
    end
  end
end
