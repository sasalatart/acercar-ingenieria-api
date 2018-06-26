module Abilities
  class NotificationsAbility < BaseAbility
    def initialize(user, params)
      super(user, params)

      return if @user.new_record?

      can %i[index seen count set_all_as_seen], Notification
    end
  end
end
