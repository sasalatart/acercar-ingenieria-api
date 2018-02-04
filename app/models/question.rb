# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  question   :string
#  answer     :text
#  author_id  :integer
#  major_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ApplicationRecord
  include Sanitizable

  before_save :sanitize_attributes

  scope :general, -> { where(major_id: nil) }
  scope :of_major, ->(major_id) { where(major_id: major_id) }
  scope :not_answered, -> { where(answer: [nil, '']) }
  scope :answered, -> { where.not(answer: [nil, '']) }

  belongs_to :author, class_name: :User
  belongs_to :major, optional: true

  validates :question, presence: true,
                       length: { minimum: 10, maximum: 255 }

  validates :answer, allow_blank: true,
                     length: { minimum: 10, maximum: 1500 }

  private

  def sanitize_attributes
    sanitize(:question, :answer)
  end
end
