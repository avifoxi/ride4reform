class AddFundGoalsToRiderReg < ActiveRecord::Migration
  def change
  	change_table :rider_regs do |t|
		  t.integer :goal
		  t.integer :raised, :default => 0
		  t.text :bio
		end
  end
end
