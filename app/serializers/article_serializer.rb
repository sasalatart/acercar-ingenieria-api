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

class ArticleSerializer < ActiveModel::Serializer
  include MajorSummarizableSerializer
  include EnrollableSerializer
  include LikeableSerializer
  include ImageableSerializer
  include AttachableSerializer

  attributes :id, :major_id, :title, :preview_url, :short_description, :content,
             :category_list, :comments_count, :approved, :created_at

  belongs_to :author, class_name: 'User',
                      serializer: UserSummarySerializer

  def self.eager_load_relation(relation)
    relation.with_attached_attachments
            .with_attached_preview
            .includes(:taggings,
                      author: { avatar_attachment: :blob },
                      major: { logo_attachment: :blob })
  end

  def preview_url
    return image_hash(object.preview, :medium)[:medium] if object.preview.attached?

    picture = object.attachments.detect do |attachment|
      attachment.variable? || attachment.previewable?
    end
    return nil unless picture

    method = picture.variable? ? :variant : :preview
    resize_options = { resize: ImageableSerializer::SIZES[:medium] }
    rails_representation_url(picture.send(method, resize_options))
  end
end
