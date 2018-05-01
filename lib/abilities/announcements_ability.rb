module Abilities
  class AnnouncementsAbility < BaseAbility
    def initialize(user, params)
      super(user, params)

      can %i[pinned], Announcement
    end
  end
end
