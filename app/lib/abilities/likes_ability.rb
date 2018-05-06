module Abilities
  class LikesAbility < BaseAbility
    def initialize(user, params)
      super(user, params)

      return if @user.new_record?

      can %i[create], Like
      can %i[destroy], Like, user_id: @user.id
    end
  end
end
