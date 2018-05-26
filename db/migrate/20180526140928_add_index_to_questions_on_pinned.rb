class AddIndexToQuestionsOnPinned < ActiveRecord::Migration[5.2]
  def change
    add_index :questions, :pinned
  end
end
