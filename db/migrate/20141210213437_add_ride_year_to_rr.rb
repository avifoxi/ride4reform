class AddRideYearToRr < ActiveRecord::Migration
  def change
  	change_table :rider_regs do |t|
      t.references :ride_year
		end
  end
end
