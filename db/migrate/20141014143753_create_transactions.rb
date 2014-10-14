class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
    	t.integer :amount
    	t.string :paypal_id
    	t.references :user
      t.timestamps
    end
  end
end
