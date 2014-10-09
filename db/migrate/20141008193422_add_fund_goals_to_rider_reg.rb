class AddFundGoalsToRiderReg < ActiveRecord::Migration
  def change
  	change_table :rider_regs do |t|
		  t.integer :goal
		  t.integer :raised
		  t.text :bio
		end
  end
end
