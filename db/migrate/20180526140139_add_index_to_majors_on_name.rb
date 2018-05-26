class AddIndexToMajorsOnName < ActiveRecord::Migration[5.2]
  def change
    add_index :majors, :name
  end
end
