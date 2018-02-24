# == Schema Information
#
# Table name: discussions
#
#  id                :integer          not null, primary key
#  title             :string
#  description       :text
#  pinned            :boolean          default(FALSE)
#  likes_count       :integer          default(0)
#  comments_count    :integer          default(0)
#  impressions_count :integer          default(0)
#  author_id         :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class DiscussionSerializer < ActiveModel::Serializer
  include Likeable

  attributes :id, :title, :description, :pinned, :tag_list,
             :comments_count, :impressions_count, :created_at

  belongs_to :author, class_name: 'User'

  has_many :attachments
end
