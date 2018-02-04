# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ApplicationRecord
  include Sanitizable

  before_save :sanitize_attributes

  validates :name, presence: true, uniqueness: true

  private

  def sanitize_attributes
    sanitize(:name)
  end
end
