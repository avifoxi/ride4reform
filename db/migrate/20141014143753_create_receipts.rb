class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
    	t.integer :amount, :default => 0
    	t.string :paypal_id
    	t.references :user
      t.timestamps
    end
  end
end
