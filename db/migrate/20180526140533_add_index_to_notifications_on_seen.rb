class AddIndexToNotificationsOnSeen < ActiveRecord::Migration[5.2]
  def change
    add_index :notifications, :seen
  end
end
