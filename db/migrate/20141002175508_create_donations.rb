class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
    	t.references :receipt
			t.references :rider
			t.boolean :distinct_billing_address
			
      t.timestamps
    end
  end
end
