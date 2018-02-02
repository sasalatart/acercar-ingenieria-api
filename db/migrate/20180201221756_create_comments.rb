class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :author, foreign_key: { to_table: :users }
      t.references :parent_comment, foreign_key: { to_table: :comments }
      t.belongs_to :commentable, polymorphic: true

      t.timestamps
    end
    add_index :comments, %i[commentable_id commentable_type]
  end
end
