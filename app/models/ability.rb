class Ability
  include CanCan::Ability

  def initialize(user, params)
    user ||= User.new # guest user (not logged in)

    majors_user_is_admin = []
    unless user.new_record?
      majors_user_is_admin = Major.with_role(:major_admin, user).pluck(:id)
    end

    if user.active? && user.has_role?(:admin)
      can :manage, :all
    elsif user.active? && !majors_user_is_admin.empty?
      can [:update], User, id: user.id

      can [:index], :admin

      can [:update], Major, id: majors_user_is_admin
      can %i[users], Major

      can %i[index show], Article
      can %i[create update destroy], Article, major_id: majors_user_is_admin

      can %i[index create], Question
      can %i[pending], Question if majors_user_is_admin.include? params[:major_id].to_i
      can %i[update destroy], Question, major_id: majors_user_is_admin
      can %i[update destroy], Question, author_id: user.id

      can %i[index create], Comment
      can [:destroy], Comment, commentable_type: Major.name, commentable_id: majors_user_is_admin
      can %i[update destroy], Comment, author_id: user.id

      can [:create], Like
      can [:destroy], Like, user_id: user.id

      can %i[index mine pinned show create], Discussion
      can %i[update destroy], Discussion, author_id: user.id
    elsif user.active? && !user.new_record?
      can [:update], User, id: user.id

      can [:index], :admin

      can %i[users], Major

      can %i[index create], Question
      can %i[update destroy], Question, author_id: user.id

      can %i[index show], Article

      can %i[index create], Comment
      can %i[update destroy], Comment, author_id: user.id

      can [:create], Like
      can [:destroy], Like, user_id: user.id

      can %i[index mine pinned show create], Discussion
      can %i[update destroy], Discussion, author_id: user.id
    end

    can %i[index show], Major

    can [:index], Question

    can [:pinned], Announcement
  end
end
