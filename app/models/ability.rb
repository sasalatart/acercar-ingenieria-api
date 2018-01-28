class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.has_role? :admin
      can :manage, :all
    elsif user.present?
      can [:update], User, id: user.id
      can [:index, :show], Major
    end
  end
end
