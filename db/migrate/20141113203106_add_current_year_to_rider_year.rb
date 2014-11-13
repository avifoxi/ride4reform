class AddCurrentYearToRiderYear < ActiveRecord::Migration
  def change
  	change_table :ride_years do |t|
			t.integer :current, :default => 0
		end

  end
end
