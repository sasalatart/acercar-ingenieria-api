# == Schema Information
#
# Table name: major_users
#
#  id         :integer          not null, primary key
#  major_id   :integer
#  user_id    :integer
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
