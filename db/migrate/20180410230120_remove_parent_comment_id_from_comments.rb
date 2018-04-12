class RemoveParentCommentIdFromComments < ActiveRecord::Migration[5.1]
  def change
    remove_column :comments, :parent_comment_id, :integer
  end
end
