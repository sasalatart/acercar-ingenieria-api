class AddIndexToArticlesOnCreatedAtDesc < ActiveRecord::Migration[5.2]
  def change
    add_index :articles, :created_at, order: { created_at: :desc }
  end
end
