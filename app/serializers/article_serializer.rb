# == Schema Information
#
# Table name: articles
#
#  id                   :integer          not null, primary key
#  title                :string
#  short_description    :text
#  content              :text
#  major_id             :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  likes_count          :integer          default(0)
#  comments_count       :integer          default(0)
#  author_id            :integer
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

class ArticleSerializer < ActiveModel::Serializer
  include Likeable
  include Imageable

  attributes :id, :title, :short_description, :content, :picture, :major_id,
             :major_summary, :category_list, :comments_count, :created_at

  belongs_to :author, class_name: 'User',
                      serializer: UserSummarySerializer

  has_many :attachments

  def self.eager_load_relation(relation)
    relation.includes(:author, :major, :taggings, :attachments)
  end

  def picture
    image_hash(object.picture, :medium)
  end

  def major_summary
    return nil unless object.major
    MajorSummarySerializer.new(object.major)
  end
end
