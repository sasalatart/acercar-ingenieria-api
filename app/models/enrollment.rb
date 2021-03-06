# == Schema Information
#
# Table name: enrollments
#
#  id              :bigint(8)        not null, primary key
#  user_id         :bigint(8)
#  enrollable_type :string
#  enrollable_id   :bigint(8)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :enrollable, polymorphic: true

  validates :user, uniqueness: { scope: %i[enrollable_type enrollable_id] }

  validate :correct_enrollable_type

  private

  def correct_enrollable_type
    return if enrollable_type.constantize.method_defined? :enrolled_users
    errors.add(:enrollable_type, :invalid_enrollable_type)
  end
end
