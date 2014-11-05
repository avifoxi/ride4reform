class CreateRideYears < ActiveRecord::Migration
  def change
    create_table :ride_years do |t|
      t.integer :year
      t.integer :registration_fee
      t.integer :registration_fee_early
      t.integer :min_rider_fundraise
      t.date    :early_bird_cutoff

      t.timestamps
    end
  end
end
