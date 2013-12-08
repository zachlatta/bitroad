class AddSlugToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :slug, :string
    add_index :invoices, :slug, unique: true
  end
end
