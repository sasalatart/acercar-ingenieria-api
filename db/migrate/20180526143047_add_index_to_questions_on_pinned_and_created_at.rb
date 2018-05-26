class AddIndexToQuestionsOnPinnedAndCreatedAt < ActiveRecord::Migration[5.2]
  def change
    add_index :questions, %i[pinned created_at]
  end
end
