class AddMessageAndPrivacyToDonations < ActiveRecord::Migration
  def change
  	change_table :donations do |t|
			t.boolean :anonymous, :default => false
			t.text :message_to_rider
		end

  end
end
