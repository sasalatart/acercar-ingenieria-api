class AddIndexToNotificationsOnCreatedAtDesc < ActiveRecord::Migration[5.2]
  def change
    add_index :notifications, :created_at, order: { created_at: :desc }
  end
end
