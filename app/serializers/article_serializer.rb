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
#

class ArticleSerializer < ActiveModel::Serializer
  include EnrollableSerializer
  include LikeableSerializer
  include AttachableSerializer

  attributes :id, :title, :short_description, :content, :major_id, :major_summary,
             :category_list, :comments_count, :preview_url, :created_at

  belongs_to :author, class_name: 'User',
                      serializer: UserSummarySerializer

  def self.eager_load_relation(relation)
    relation.with_attached_attachments
            .includes(:taggings,
                      author: { avatar_attachment: :blob },
                      major: { logo_attachment: :blob })
  end

  def major_summary
    return nil unless object.major
    MajorSummarySerializer.new(object.major)
  end

  def preview_url
    picture = object.attachments.detect do |attachment|
      attachment.variable? || attachment.previewable?
    end
    return nil unless picture

    method = picture.variable? ? :variant : :preview
    resize_options = { resize: ImageableSerializer::SIZES[:medium] }
    rails_representation_url(picture.send(method, resize_options))
  end
end
