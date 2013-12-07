class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.boolean :completed
      t.belongs_to :listing

      t.timestamps
    end
  end
end
