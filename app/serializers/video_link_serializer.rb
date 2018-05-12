# == Schema Information
#
# Table name: video_links
#
#  id                  :bigint(8)        not null, primary key
#  title               :string
#  url                 :string
#  pinned              :boolean          default(FALSE)
#  video_linkable_type :string
#  video_linkable_id   :bigint(8)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class VideoLinkSerializer < ActiveModel::Serializer
  attributes :id, :title, :url, :video_linkable_type, :video_linkable_id,
             :pinned, :created_at
end
