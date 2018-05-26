# == Schema Information
#
# Table name: discussions
#
#  id                :bigint(8)        not null, primary key
#  title             :string
#  description       :text
#  pinned            :boolean          default(FALSE)
#  likes_count       :integer          default(0)
#  comments_count    :integer          default(0)
#  impressions_count :integer          default(0)
#  author_id         :bigint(8)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class DiscussionSummarySerializer < ActiveModel::Serializer
  attributes :id, :title, :pinned, :tag_list, :likes_count, :comments_count,
             :impressions_count, :created_at

  belongs_to :author, class_name: 'User',
                      serializer: UserSummarySerializer

  def self.eager_load_relation(relation)
    relation.includes(:taggings, author: { avatar_attachment: :blob })
  end
end
