class AddIndexToUsersOnGenerationLastNameAndFirstName < ActiveRecord::Migration[5.2]
  def change
    add_index :users, %i[generation last_name first_name], order: { generation: :desc, last_name: :asc, first_name: :asc }
  end
end
