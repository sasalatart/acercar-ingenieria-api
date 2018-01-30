class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.has_role? :admin
      can :manage, :all
    elsif !user.new_record?
      can [:update], Major, id: Major.with_role(:major_admin, user).pluck(:id)

      can [:update], User, id: user.id
      can %i[users articles admins], Major
      can %i[index show], Article
    end

    can %i[index show], Major
    can [:pinned], Announcement
  end
end
