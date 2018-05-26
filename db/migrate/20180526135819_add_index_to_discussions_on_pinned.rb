class AddIndexToDiscussionsOnPinned < ActiveRecord::Migration[5.2]
  def change
    add_index :discussions, :pinned
  end
end
