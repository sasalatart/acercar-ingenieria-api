class AddApprovedToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :approved, :boolean, default: false
  end
end
