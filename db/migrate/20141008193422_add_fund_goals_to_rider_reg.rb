class AddFundGoalsToRiderReg < ActiveRecord::Migration
  def change
  	change_table :rider_regs do |t|
      t.decimal :goal, :precision => 10, :scale => 2, :default => 0
      t.decimal :raised, :precision => 10, :scale => 2, :default => 0
		  t.text :bio
		end
  end
end
