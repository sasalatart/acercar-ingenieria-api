class AddAttachmentPictureToAnnouncements < ActiveRecord::Migration[5.1]
  def self.up
    change_table :announcements do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :announcements, :picture
  end
end
