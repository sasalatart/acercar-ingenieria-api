class AddAttachmentResourceToCredits < ActiveRecord::Migration[5.1]
  def self.up
    change_table :credits do |t|
      t.attachment :resource
    end
  end

  def self.down
    remove_attachment :credits, :resource
  end
end
