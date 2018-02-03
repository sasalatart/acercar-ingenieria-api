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

class Discussion < ApplicationRecord
  before_save :sanitize

  scope :pinned, -> { where(pinned: true) }

  acts_as_taggable

  is_impressionable counter_cache: true,
                    unique: true

  belongs_to :author, class_name: :User

  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  accepts_nested_attributes_for :attachments, allow_destroy: true

  validates :title, presence: true,
                    length: { minimum: 10, maximum: 255 }

  validates :description, presence: true,
                          length: { minimum: 10, maximum: 2000 }

  private

  def sanitize
    self.title = Sanitize.fragment(title, Sanitize::Config::RELAXED)
    self.description = Sanitize.fragment(description, Sanitize::Config::RELAXED)
  end
end
