class AddIndexToVideoLinksOnPinnedAndCreatedAt < ActiveRecord::Migration[5.2]
  def change
    add_index :video_links, %i[pinned created_at]
  end
end
