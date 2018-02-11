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
  attributes :id, :title, :short_description, :content, :major_id,
             :likes_count, :comments_count, :picture, :created_at

  belongs_to :author, class_name: 'User'

  def picture
    return nil unless object.picture.exists?
    { medium: object.picture.url(:medium) }
  end
end
