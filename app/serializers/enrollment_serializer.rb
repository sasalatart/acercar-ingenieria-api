# == Schema Information
#
# Table name: enrollments
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  enrollable_type :string
#  enrollable_id   :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class EnrollmentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :enrollable_type, :enrollable_id, :created_at
end
