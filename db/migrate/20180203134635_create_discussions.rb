class CreateDiscussions < ActiveRecord::Migration[5.1]
  def change
    create_table :discussions do |t|
      t.string :title
      t.text :description
      t.boolean :pinned, default: false
      t.integer :likes_count, default: 0
      t.integer :comments_count, default: 0
      t.integer :impressions_count, default: 0

      t.references :author, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
