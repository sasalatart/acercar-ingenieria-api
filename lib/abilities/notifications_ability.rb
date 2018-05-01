module Abilities
  class NotificationsAbility < BaseAbility
    def initialize(user, params)
      super(user, params)

      return if @user.new_record?

      can %i[index count seen], Notification
    end
  end
end
