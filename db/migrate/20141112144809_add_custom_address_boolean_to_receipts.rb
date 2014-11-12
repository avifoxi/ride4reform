class AddCustomAddressBooleanToReceipts < ActiveRecord::Migration
  def change

		change_table :receipts do |t|
			t.boolean :reference_user_address, :default => true
		end

  end
end
