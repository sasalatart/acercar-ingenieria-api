class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.has_role? :admin
      can :manage, :all
    elsif user.present?
      can [:update], Major, id: Major.with_role(:major_admin, user).pluck(:id)
      can [:update], User, id: user.id
      can [:pinned], Announcement
      can %i[index show users articles admins], Major
      can %i[index show], Article
    end
  end
end
