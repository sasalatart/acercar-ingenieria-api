module LikeableSerializer
  extend ActiveSupport::Concern

  included do
    attributes :likes_count, :liked_by_current_user
  end

  def liked_by_current_user
    return false unless current_user
    current_user.likes.where(likeable_type: object.class.name,
                             likeable_id: object.id).count > 0
  end
end
