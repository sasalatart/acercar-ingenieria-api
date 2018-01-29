class CreateAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.string :attachable_type
      t.integer :attachable_id

      t.timestamps
    end
  end
end
