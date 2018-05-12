module EmailViewableSerializer
  extend ActiveSupport::Concern

  included do
    attributes :email
  end

  def email
    object.email if current_user && current_user.can_see_email_for?(object)
  end
end
