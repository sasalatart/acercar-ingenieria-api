module Enrollable
  extend ActiveSupport::Concern

  included do
    has_many :enrollments, as: :enrollable, dependent: :destroy
    has_many :enrolled_users, through: :enrollments, source: :user
  end

  def enroll!(user)
    enrollments.create!(user: user)
  end

  def unenroll(user)
    enrollments.where(user: user).destroy_all
  end
end
