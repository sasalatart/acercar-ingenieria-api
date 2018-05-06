module Abilities
  class DiscussionsAbility < BaseAbility
    def initialize(user, params)
      super(user, params)

      return if @user.new_record?

      can %i[index mine show create], Discussion
      can %i[update destroy], Discussion, author_id: @user.id
    end
  end
end
