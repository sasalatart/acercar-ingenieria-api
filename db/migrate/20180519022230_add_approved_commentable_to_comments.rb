class AddApprovedCommentableToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :approved_commentable, :boolean, default: true
  end
end
