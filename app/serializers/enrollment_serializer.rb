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

class EnrollmentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :enrollable_type, :enrollable_id, :created_at
end
