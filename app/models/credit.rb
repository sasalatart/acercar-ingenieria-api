# == Schema Information
#
# Table name: credits
#
#  id            :bigint(8)        not null, primary key
#  resource_name :string
#  resource_url  :string
#  author_name   :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Credit < ApplicationRecord
  has_one_attached :resource

  validates :resource_name, presence: true
  validates :resource_url, presence: true
  validates :author_name, presence: true
  validates :resource, image: { presence: true, max_size: 2.megabytes }
end
