class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
    	t.decimal :amount, :precision => 10, :scale => 2, :default => 0
    	t.string :paypal_id
    	t.references :user
      t.timestamps
    end
  end
end
