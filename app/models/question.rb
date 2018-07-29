# == Schema Information
#
# Table name: questions
#
#  id         :bigint(8)        not null, primary key
#  question   :string
#  answer     :text
#  author_id  :bigint(8)
#  major_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  pinned     :boolean          default(FALSE)
#

class Question < ApplicationRecord
  include SanitizableModel

  DEFAULT_ORDER = [pinned: :desc, created_at: :desc].freeze

  before_save :sanitize_attributes

  scope :general, -> { where(major_id: nil) }
  scope :of_major, ->(major_id) { where(major_id: major_id) }
  scope :not_answered, -> { where(answer: [nil, '']).order(DEFAULT_ORDER) }
  scope :answered, -> { where.not(answer: [nil, '']).order(DEFAULT_ORDER) }

  belongs_to :author, class_name: :User,
                      inverse_of: :questions

  belongs_to :major, optional: true

  validates :question, presence: true,
                       length: { minimum: 10, maximum: 255 }

  validates :answer, allow_blank: true,
                     length: { minimum: 10, maximum: 1500 }

  def self.scoped(params)
    params[:major_id] ? Question.of_major(params[:major_id]) : Question.general
  end

  private

  def sanitize_attributes
    sanitize(:question, :answer)
  end
end
