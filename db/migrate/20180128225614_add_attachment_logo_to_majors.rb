class AddAttachmentLogoToMajors < ActiveRecord::Migration[5.1]
  def self.up
    change_table :majors do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :majors, :logo
  end
end
