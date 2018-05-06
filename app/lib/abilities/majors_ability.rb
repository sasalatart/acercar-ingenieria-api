module Abilities
  class MajorsAbility < BaseAbility
    def initialize(user, params)
      super(user, params)

      unless @majors_user_is_admin.empty?
        can %i[update email], Major, id: @majors_user_is_admin
      end

      can %i[personal_email], Major unless @user.new_record?

      can %i[index show], Major
    end
  end
end
