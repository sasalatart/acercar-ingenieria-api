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

class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :question, :answer, :major_id, :created_at

  belongs_to :author, class_name: 'User'
end
