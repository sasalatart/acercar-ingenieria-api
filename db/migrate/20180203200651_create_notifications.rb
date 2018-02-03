class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.integer :action_type
      t.boolean :seen, default: false
      t.references :owner, foreign_key: { to_table: :users }
      t.references :notificator, foreign_key: { to_table: :users }
      t.belongs_to :notifyable, polymorphic: true

      t.timestamps
    end
    add_index :notifications, %i[notifyable_id notifyable_type]
  end
end
