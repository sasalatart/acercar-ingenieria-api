class RemoveTextFromAnnouncements < ActiveRecord::Migration[5.1]
  def change
    remove_column :announcements, :text
  end
end
