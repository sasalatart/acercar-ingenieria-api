module Abilities
  class CreditsAbility < BaseAbility
    def initialize(user, params)
      super(user, params)

      can %i[index], Credit
    end
  end
end
