# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
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

class UserSerializer < ActiveModel::Serializer
  include EmailViewableSerializer
  include ImageableSerializer

  attributes :id, :first_name, :last_name, :generation, :bio, :avatar,
             :majors_of_interest, :admin, :admin_of_majors, :created_at

  def self.eager_load_relation(relation)
    relation.with_attached_avatar
  end

  def majors_of_interest
    ActiveModelSerializers::SerializableResource.new(
      object.major_users.includes(major: { logo_attachment: :blob }),
      each_serializer: MajorOfInterestSerializer
    )
  end

  def admin
    object.has_role? :admin
  end

  def admin_of_majors
    ActiveModelSerializers::SerializableResource.new(
      Major.with_role(:major_admin, object),
      each_serializer: MajorSummarySerializer
    )
  end

  def avatar
    image_hash(object.avatar, :thumb, :medium)
  end
end
