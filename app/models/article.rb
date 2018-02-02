# == Schema Information
#
# Table name: articles
#
#  id                :integer          not null, primary key
#  title             :string
#  short_description :text
#  content           :text
#  major_id          :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  likes_count       :integer          default(0)
#  comments_count    :integer          default(0)
#

class Article < ApplicationRecord
  belongs_to :major, optional: true

  has_many :article_categories, dependent: :destroy
  has_many :categories, through: :article_categories
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  accepts_nested_attributes_for :article_categories, allow_destroy: true
  accepts_nested_attributes_for :attachments, allow_destroy: true

  validates :title, presence: true, uniqueness: true
  validates :short_description, presence: true, length: { maximum: 300 }
  validates :content, presence: true

  def self.find_by_categories(category_ids)
    return Article.all unless category_ids

    Article.joins(:categories)
           .where(categories: { id: category_ids })
  end
end
