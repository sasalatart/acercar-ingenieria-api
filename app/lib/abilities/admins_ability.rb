module Abilities
  class AdminsAbility < BaseAbility
    def initialize(user, params)
      super(user, params)

      return if @user.new_record?

      if @user.has_role?(:admin)
        cannot %i[demote], :admin if @user.id == params[:id].to_i
      end

      can %i[index], :admin
    end
  end
end
