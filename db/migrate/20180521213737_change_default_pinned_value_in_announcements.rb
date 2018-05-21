class ChangeDefaultPinnedValueInAnnouncements < ActiveRecord::Migration[5.2]
  def change
    change_column_default :announcements, :pinned, from: true, to: false
  end
end
