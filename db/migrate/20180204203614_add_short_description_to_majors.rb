class AddShortDescriptionToMajors < ActiveRecord::Migration[5.1]
  def change
    add_column :majors, :short_description, :text
  end
end
