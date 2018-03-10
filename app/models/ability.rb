class Ability
  include CanCan::Ability

  def initialize(user, params)
    user ||= User.new # guest user (not logged in)

    majors_user_is_admin = []
    unless user.new_record?
      majors_user_is_admin = Major.with_role(:major_admin, user).pluck(:id)
    end

    if user.has_role?(:admin)
      can :manage, :all
      cannot [:toggle], :admin if user.id == params[:id].to_i
    elsif !majors_user_is_admin.empty?
      can %i[index show], User
      can %i[update active], User, id: user.id
      can %i[destroy], User if MajorUser.find_by(user_id: params[:id].to_i, major_id: majors_user_is_admin)

      can [:index], :admin

      can %i[update broadcast], Major, id: majors_user_is_admin

      can %i[index show create], Article
      can %i[update destroy], Article, major_id: majors_user_is_admin
      can %i[update destroy], Article, author_id: user.id

      can %i[index], Category

      can %i[index create], Question
      can %i[pending], Question if majors_user_is_admin.include? params[:major_id].to_i
      can %i[update destroy], Question, major_id: majors_user_is_admin
      can %i[update destroy], Question, author_id: user.id

      can %i[index create], Comment
      can [:destroy], Comment, commentable_type: Major.name, commentable_id: majors_user_is_admin
      can %i[update destroy], Comment, author_id: user.id

      can %i[create destroy], Like

      can %i[index mine pinned show create], Discussion
      can %i[update destroy], Discussion, author_id: user.id

      can %i[create], Enrollment
      can %i[destroy], Enrollment, user_id: user.id

      can %i[index seen clear], Notification
      can %i[read], Notification, owner_id: user.id
    elsif !user.new_record?
      can %i[index show], User
      can %i[update active], User, id: user.id

      can [:index], :admin

      can %i[index create], Question
      can %i[update destroy], Question, author_id: user.id

      can %i[index show create], Article
      can %i[update destroy], Article, author_id: user.id

      can %i[index], Category

      can %i[index create], Comment
      can %i[update destroy], Comment, author_id: user.id

      can %i[create destroy], Like

      can %i[index mine pinned show create], Discussion
      can %i[update destroy], Discussion, author_id: user.id

      can %i[create], Enrollment
      can %i[destroy], Enrollment, user_id: user.id

      can %i[index seen clear], Notification
      can %i[read], Notification, owner_id: user.id
    end

    can %i[index show], Major

    can [:index], Question

    can %i[index show], Article

    can %i[index], Category

    can [:pinned], Announcement
  end
end
