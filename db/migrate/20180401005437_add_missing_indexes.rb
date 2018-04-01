class AddMissingIndexes < ActiveRecord::Migration[5.1]
  def change
    add_index :articles, %i[title short_description]
    add_index :attachments, %i[attachable_id attachable_type]
    add_index :discussions, :title
    add_index :users, %i[first_name last_name generation]
  end
end
