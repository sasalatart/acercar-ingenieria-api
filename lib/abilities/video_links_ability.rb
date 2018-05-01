module Abilities
  class VideoLinksAbility < BaseAbility
    def initialize(user, params)
      super(user, params)

      unless @majors_user_is_admin.empty?
        can %i[create update destroy], VideoLink if @majors_user_is_admin.include? params[:major_id].to_i
      end

      can %i[index], VideoLink
    end
  end
end
