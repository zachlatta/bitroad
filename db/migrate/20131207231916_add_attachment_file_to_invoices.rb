class AddAttachmentFileToInvoices < ActiveRecord::Migration
  def self.up
    change_table :invoices do |t|
      t.attachment :file
    end
  end

  def self.down
    drop_attached_file :invoices, :file
  end
end
