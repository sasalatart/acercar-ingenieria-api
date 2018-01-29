class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :short_description
      t.text :content
      t.references :major, foreign_key: true

      t.timestamps
    end
  end
end
