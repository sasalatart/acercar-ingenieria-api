class CreateMajors < ActiveRecord::Migration[5.1]
  def change
    create_table :majors do |t|
      t.string :name
      t.integer :category
      t.text :description
      t.string :video_url_code

      t.timestamps
    end
  end
end
