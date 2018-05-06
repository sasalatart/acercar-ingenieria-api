module Abilities
  class CategoriesAbility < BaseAbility
    def initialize(user, params)
      super(user, params)

      can %i[index], Category
    end
  end
end
