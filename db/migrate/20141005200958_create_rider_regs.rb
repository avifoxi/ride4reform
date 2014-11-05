class CreateRiderRegs < ActiveRecord::Migration
  def change
    create_table :rider_regs do |t|
    	t.references :ride_year
    	t.references :rider
    	t.string :ride_option

    	t.date :birthdate

    	t.string :primary_phone
    	t.string :secondary_phone

      t.boolean :paid, default: false

      t.timestamps
    end
  end
end
