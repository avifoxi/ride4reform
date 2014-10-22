class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
    	t.references :receipt
			t.references :rider
			
      t.timestamps
    end
  end
end
