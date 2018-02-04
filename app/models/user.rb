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
#  active                 :boolean          default(TRUE)
#  bio                    :string
#

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable
  include DeviseTokenAuth::Concerns::User
  include Sanitizable

  rolify

  before_save :sanitize_attributes
  before_save :capitalize

  scope :active, -> { where(active: true) }

  has_many :major_users, dependent: :destroy
  has_many :majors, through: :major_users

  has_many :discussions, dependent: :destroy,
                         foreign_key: :author_id

  has_many :notifications, dependent: :destroy,
                           foreign_key: :owner_id

  accepts_nested_attributes_for :major_users, allow_destroy: true

  validates :email, presence: true,
                    format: { with: /[0-9._%a-z\-]+@(?:uc|puc|ing.puc)\.cl/i }

  validates :first_name, :last_name, presence: true, length: { maximum: 25 }

  validates :generation, presence: true,
                         numericality: { greater_than_or_equal_to: 1904,
                                         less_than_or_equal_to: Time.now.year }

  validates :bio, allow_blank: true,
                  length: { maximum: 255 }

  def toggle_admin(major_id)
    unless major_id
      has_role?(:admin) ? remove_role(:admin) : add_role(:admin)
      return self
    end

    @major = Major.find(major_id)
    admin = has_role?(:major_admin, @major)
    admin ? remove_role(:major_admin, @major) : add_role(:major_admin, @major)
    self
  end

  def admin_of_something?
    has_role?(:admin) || Major.with_role(:major_admin, self).size.nonzero?
  end

  def active_for_authentication?
    super && active
  end

  def inactive_message
    'Sorry, this account has been deactivated.'
  end

  private

  def sanitize_attributes
    sanitize(:email, :first_name, :last_name, :bio)
  end

  def capitalize
    %i[first_name last_name].each do |name|
      self[name] = self[name].split.map(&:capitalize).join(' ')
    end
  end
end
