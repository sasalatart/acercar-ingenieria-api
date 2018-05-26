class AddIndexToArticlesOnApproved < ActiveRecord::Migration[5.2]
  def change
    add_index :articles, :approved
  end
end
