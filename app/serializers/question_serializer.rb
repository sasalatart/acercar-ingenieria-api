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
#  pinned     :boolean          default(FALSE)
#

class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :question, :answer, :pinned, :major_summary, :created_at

  belongs_to :author, class_name: 'User'

  def self.eager_load_relation(relation)
    relation.includes(:author, :major)
  end

  def major_summary
    return nil unless object.major
    MajorSummarySerializer.new(object.major)
  end
end
