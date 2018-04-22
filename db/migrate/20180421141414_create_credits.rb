class CreateCredits < ActiveRecord::Migration[5.1]
  def change
    create_table :credits do |t|
      t.string :resource_name
      t.string :resource_url
      t.string :author_name

      t.timestamps
    end
  end
end
