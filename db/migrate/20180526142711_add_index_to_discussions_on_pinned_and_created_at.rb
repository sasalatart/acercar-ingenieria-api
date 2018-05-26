class AddIndexToDiscussionsOnPinnedAndCreatedAt < ActiveRecord::Migration[5.2]
  def change
    add_index :discussions, %i[pinned created_at]
  end
end
