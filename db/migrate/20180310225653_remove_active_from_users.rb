class RemoveActiveFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :active, :boolean
  end
end
