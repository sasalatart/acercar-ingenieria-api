module Abilities
  class VideoLinksAbility < BaseAbility
    def initialize(user, params)
      super(user, params)

      unless @majors_user_is_admin.empty?
        can %i[create], VideoLink if @majors_user_is_admin.include? params[:major_id].to_i
        can %i[update destroy], VideoLink, video_linkable_type: Major.name, video_linkable_id: @majors_user_is_admin
      end

      can %i[index], VideoLink
    end
  end
end
