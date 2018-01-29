class CreateAnnouncements < ActiveRecord::Migration[5.1]
  def change
    create_table :announcements do |t|
      t.text :text
      t.boolean :pinned, default: true

      t.timestamps
    end
  end
end
