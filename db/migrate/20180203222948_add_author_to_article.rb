class AddAuthorToArticle < ActiveRecord::Migration[5.1]
  def change
    add_reference :articles, :author, foreign_key: { to_table: :users }, index: true
  end
end
