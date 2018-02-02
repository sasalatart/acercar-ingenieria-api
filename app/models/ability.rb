class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    majors_user_is_admin = []
    unless user.new_record?
      majors_user_is_admin = Major.with_role(:major_admin, user).pluck(:id)
    end

    if user.active? && user.has_role?(:admin)
      can :manage, :all
    elsif user.active? && !majors_user_is_admin.empty?
      can [:update], User, id: user.id

      can [:update], Major, id: majors_user_is_admin
      can %i[users admins articles comments], Major
      can [:pending_questions], Major, id: majors_user_is_admin

      can %i[index show comments], Article
      can %i[create update destroy], Article, major_id: majors_user_is_admin

      can [:create], Question
      can %i[update destroy], Question, major_id: majors_user_is_admin
      can %i[update destroy], Question, author_id: user.id

      can [:create], Comment
      can [:destroy], Comment, commentable_type: Major.name, commentable_id: majors_user_is_admin
      can %i[update destroy], Comment, author_id: user.id

      can [:create], Like
      can [:destroy], Like, user_id: user.id
    elsif user.active? && !user.new_record?
      can [:update], User, id: user.id

      can %i[users admins articles comments], Major

      can [:create], Question
      can %i[update destroy], Question, author_id: user.id

      can %i[index show comments], Article

      can [:create], Comment
      can %i[update destroy], Comment, author_id: user.id

      can [:create], Like
      can [:destroy], Like, user_id: user.id
    end

    can %i[index show questions], Major

    can [:index], Question

    can [:pinned], Announcement
  end
end
