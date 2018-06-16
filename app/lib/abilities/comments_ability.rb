module Abilities
  class CommentsAbility < BaseAbility
    def initialize(user, params)
      super(user, params)

      return if @user.new_record?

      unless @majors_user_is_admin.empty?
        can %i[index show destroy], Comment, commentable_type: Major.name, commentable_id: @majors_user_is_admin
      end

      can %i[index show], Comment if author_of_commentable?(params)
      can %i[index create], Comment if approved_commentable?(params)
      can %i[show], Comment, approved_commentable: true
      can %i[update destroy], Comment, approved_commentable: true, author_id: @user.id
    end

    def author_of_commentable?(params)
      commentable = find_commentable(params)
      commentable.respond_to?(:author_id) && commentable.author_id == @user.id
    end

    def approved_commentable?(params)
      commentable = find_commentable(params)
      !commentable.respond_to?(:approved?) || commentable.approved?
    end
  end
end
