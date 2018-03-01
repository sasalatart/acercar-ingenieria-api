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
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable
  include DeviseTokenAuth::Concerns::User
  include Sanitizable
  include Adminable

  rolify

  before_save :sanitize_attributes
  before_save :capitalize

  scope :active, -> { where(active: true) }

  has_many :major_users, dependent: :destroy
  has_many :majors, through: :major_users

  has_many :comments, dependent: :destroy,
                      foreign_key: :author_id

  has_many :likes, dependent: :destroy

  has_many :discussions, dependent: :destroy,
                         foreign_key: :author_id

  has_many :notifications, dependent: :destroy,
                           foreign_key: :owner_id

  has_attached_file :avatar, styles: { thumb: '75x75>', medium: '200x200>' },
                             convert_options: { display: '-quality 90 -strip' },
                             dependent: :destroy

  accepts_nested_attributes_for :major_users, allow_destroy: true

  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: /[0-9._%a-z\-]+@(?:uc|puc|ing.puc)\.cl/i }

  validates :password, presence: true,
                       if: :new_record?

  validates :password, confirmation: true,
                       length: { minimum: 8 },
                       if: :password_sent?

  validates :first_name, :last_name, presence: true, length: { maximum: 25 }

  validates :generation, presence: true,
                         numericality: { greater_than_or_equal_to: 1904,
                                         less_than_or_equal_to: Time.now.year }

  validates :bio, allow_blank: true,
                  length: { maximum: 255 }

  validates_attachment :avatar, content_type: { content_type: /\Aimage\/.*\z/ },
                                size: { in: 0..1.megabyte }

  def active_for_authentication?
    super && active
  end

  def inactive_message
    'Sorry, this account has been deactivated.'
  end

  def token_validation_response
    UserSerializer.new(self).as_json
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

  def password_sent?
    !password.nil?
  end
end
