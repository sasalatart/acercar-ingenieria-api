# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  email                  :string
#  first_name             :string
#  last_name              :string
#  generation             :integer
#  tokens                 :json
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  bio                    :string
#

class UserSummarySerializer < ActiveModel::Serializer
  include EmailViewableSerializer
  include ImageableSerializer

  attributes :id, :first_name, :last_name, :generation, :avatar, :created_at

  def self.eager_load_relation(relation)
    relation.with_attached_avatar
  end

  def avatar
    image_hash(object.avatar, :thumb, :medium)
  end
end
