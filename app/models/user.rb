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
#

class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable
  include DeviseTokenAuth::Concerns::User

  validates :email, presence: true,
                    format: { with: /[0-9._%a-z\-]+@(?:uc|puc|ing.puc)\.cl/i }

  validates :first_name, :last_name, presence: true, length: { maximum: 20 }

  validates :generation, presence: true,
                         numericality: { greater_than_or_equal_to: 1904,
                                         less_than_or_equal_to: Time.now.year }

  def toggle_active(active)
    update(active: active)
  end

  def active_for_authentication?
    super && active
  end

  def inactive_message
    'Sorry, this account has been deactivated.'
  end
end
