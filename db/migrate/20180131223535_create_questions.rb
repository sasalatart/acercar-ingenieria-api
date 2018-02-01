class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :question
      t.text :answer
      t.references :author, foreign_key: { to_table: :users }
      t.references :major, foreign_key: true

      t.timestamps
    end
  end
end
