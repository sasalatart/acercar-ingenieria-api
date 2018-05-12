# == Schema Information
#
# Table name: major_users
#
#  id         :bigint(8)        not null, primary key
#  major_id   :bigint(8)
#  user_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MajorUser < ApplicationRecord
  belongs_to :major
  belongs_to :user

  validates :user, presence: true

  validates :major, presence: true,
                    uniqueness: { scope: :user }
end
