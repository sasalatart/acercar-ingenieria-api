class AddPinnedToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :pinned, :boolean, default: false
  end
end
