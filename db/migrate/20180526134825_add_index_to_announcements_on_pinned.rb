class AddIndexToAnnouncementsOnPinned < ActiveRecord::Migration[5.2]
  def change
    add_index :announcements, :pinned
  end
end
