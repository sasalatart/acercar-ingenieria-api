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

class LikeSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :likeable_type, :likeable_id, :created_at
end
