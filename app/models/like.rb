# == Schema Information
#
# Table name: likes
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  likeable_type :string
#  likeable_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true,
                        counter_cache: true

  validates :user, uniqueness: { scope: %i[likeable_type likeable_id] }
end
