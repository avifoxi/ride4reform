class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
    	t.integer :amount
			t.references :donor
			t.references :rider
			t.string :address
      t.timestamps
    end
  end
end
