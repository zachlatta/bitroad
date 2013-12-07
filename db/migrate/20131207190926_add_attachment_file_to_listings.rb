class AddAttachmentFileToListings < ActiveRecord::Migration
  def self.up
    change_table :listings do |t|
      t.attachment :file
    end
  end

  def self.down
    drop_attached_file :listings, :file
  end
end
