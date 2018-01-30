# == Schema Information
#
# Table name: majors
#
#  id                :integer          not null, primary key
#  name              :string
#  category          :integer
#  description       :text
#  video_url_code    :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  logo_file_name    :string
#  logo_content_type :string
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#

class Major < ApplicationRecord
  resourcify

  enum category: { disciplinary: 0, interdisciplinary: 1 }

  has_many :major_users, dependent: :destroy
  has_many :users, through: :major_users
  has_many :articles

  has_attached_file :logo,
                    styles: { thumb: '200x200>' },
                    convert_options: { display: '-quality 90 -strip' },
                    dependent: :destroy

  validates :category, :description, :video_url_code, presence: true

  validates :name, presence: true,
                   uniqueness: true

  validates :category, presence: true,
                       inclusion: { in: categories.keys }

  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/
  validates_attachment_size :logo, less_than: 2.megabytes

  def toggle_admin(user_id)
    user = User.find(user_id)
    action = user.has_role?(:major_admin, self) ? 'remove_role' : 'add_role'
    user.send(action.to_sym, :major_admin, self)
  end
end
