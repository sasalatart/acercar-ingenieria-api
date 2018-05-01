module Abilities
  class BaseAbility
    include CanCan::Ability

    def initialize(user, params)
      @user = user || User.new # guest user (not logged in)

      @majors_user_is_admin = @user.new_record? ? [] : Major.with_role(:major_admin, @user).pluck(:id)

      can :manage, :all if @user.has_role?(:admin)
    end
  end
end
