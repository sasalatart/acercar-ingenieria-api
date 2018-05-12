# == Schema Information
#
# Table name: likes
#
#  id            :bigint(8)        not null, primary key
#  user_id       :bigint(8)
#  likeable_type :string
#  likeable_id   :bigint(8)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true,
                        counter_cache: true

  validates :user, uniqueness: { scope: %i[likeable_type likeable_id] }
end
