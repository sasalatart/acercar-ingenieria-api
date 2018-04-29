class CreateVideoLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :video_links do |t|
      t.string :title
      t.string :url
      t.boolean :pinned, default: false
      t.belongs_to :video_linkable, polymorphic: true

      t.timestamps
    end
  end
end
