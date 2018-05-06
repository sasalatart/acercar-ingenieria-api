module Abilities
  class EnrollmentsAbility < BaseAbility
    def initialize(user, params)
      super(user, params)

      return if @user.new_record?

      can %i[create], Enrollment
      can %i[destroy], Enrollment, user_id: @user.id
    end
  end
end
