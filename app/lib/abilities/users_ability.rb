module Abilities
  class UsersAbility < BaseAbility
    def initialize(user, params)
      super(user, params)

      return if @user.new_record?

      unless @majors_user_is_admin.empty?
        can %i[destroy], User if MajorUser.find_by(user_id: params[:id].to_i, major_id: @majors_user_is_admin)
      end

      can %i[index show], User
      can %i[update destroy], User, id: @user.id
    end
  end
end
