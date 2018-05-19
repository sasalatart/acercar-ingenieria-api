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

class QuestionSerializer < ActiveModel::Serializer
  include MajorSummarizableSerializer

  attributes :id, :question, :answer, :pinned, :created_at

  belongs_to :author, class_name: 'User',
                      serializer: UserSummarySerializer

  def self.eager_load_relation(relation)
    relation.includes(:author, :major)
  end
end
