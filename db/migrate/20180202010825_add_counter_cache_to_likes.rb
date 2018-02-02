class AddCounterCacheToLikes < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :likes_count, :integer, default: 0
    add_column :comments, :likes_count, :integer, default: 0
  end
end
