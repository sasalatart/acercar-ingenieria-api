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

class LikeSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :likeable_type, :likeable_id, :created_at
end
