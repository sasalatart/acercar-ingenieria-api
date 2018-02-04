class AddAttachmentPictureToArticles < ActiveRecord::Migration[5.1]
  def self.up
    change_table :articles do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :articles, :picture
  end
end
