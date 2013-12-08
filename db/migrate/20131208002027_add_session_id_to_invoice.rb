class AddSessionIdToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :session_id, :string
  end
end
