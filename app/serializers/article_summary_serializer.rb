# == Schema Information
#
# Table name: articles
#
#  id                :bigint(8)        not null, primary key
#  title             :string
#  short_description :text
#  content           :text
#  major_id          :bigint(8)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  likes_count       :integer          default(0)
#  comments_count    :integer          default(0)
#  author_id         :bigint(8)
#  approved          :boolean          default(FALSE)
#

class ArticleSummarySerializer < ActiveModel::Serializer
  include MajorSummarizableSerializer
  include PreviewableSerializer

  attributes :id, :title, :short_description, :category_list, :likes_count,
             :comments_count, :approved, :created_at

  belongs_to :author, class_name: 'User',
                      serializer: UserSummarySerializer

  def self.eager_load_relation(relation)
    relation.with_attached_preview
            .with_attached_attachments
            .includes(:taggings,
                      author: { avatar_attachment: :blob },
                      major: { logo_attachment: :blob })
  end
end
