class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
    	t.references :transaction
			t.references :rider
			t.boolean :distinct_billing_address
			
      t.timestamps
    end
  end
end
