class AddIndexToQuestionsOnAnswer < ActiveRecord::Migration[5.2]
  def change
    add_index :questions, :answer
  end
end
