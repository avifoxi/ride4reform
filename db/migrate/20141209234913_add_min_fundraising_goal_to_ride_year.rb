class AddMinFundraisingGoalToRideYear < ActiveRecord::Migration
  def change
  	change_table :ride_years do |t|
      t.integer :min_goal, :default => 2000
		end
  end
end
