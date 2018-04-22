# == Schema Information
#
# Table name: credits
#
#  id                    :integer          not null, primary key
#  resource_name         :string
#  resource_url          :string
#  author_name           :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  resource_file_name    :string
#  resource_content_type :string
#  resource_file_size    :integer
#  resource_updated_at   :datetime
#

class Credit < ApplicationRecord
  has_attached_file :resource, styles: { thumb: '75x75>', medium: '200x200>' },
                               convert_options: { display: '-quality 90 -strip' },
                               dependent: :destroy

  validates :resource_name, presence: true
  validates :resource_url, presence: true
  validates :author_name, presence: true

  validates_attachment :resource, presence: true,
                                  content_type: { content_type: /\Aimage\/.*\z/ },
                                  size: { in: 0..2.megabytes }
end
