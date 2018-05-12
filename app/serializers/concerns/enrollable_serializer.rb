module EnrollableSerializer
  extend ActiveSupport::Concern

  included do
    attributes :enrolled_by_current_user
  end

  def enrolled_by_current_user
    return false unless current_user
    current_user.enrollments.where(enrollable_type: object.class.name,
                                   enrollable_id: object.id).count > 0
  end
end
