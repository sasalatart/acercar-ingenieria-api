module Abilities
  class BaseAbility
    include CanCan::Ability
    include ActAsPolymorphic

    def initialize(user, params)
      @user = user || User.new # guest user (not logged in)

      @majors_user_is_admin = @user.new_record? ? [] : Major.ids_where_is_admin(@user)

      can :manage, :all if @user.has_role?(:admin)
    end
  end
end
