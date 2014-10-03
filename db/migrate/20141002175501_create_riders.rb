class CreateRiders < ActiveRecord::Migration
  def change
    create_table :riders do |t|
    	t.string :first_name
    	t.string :last_name
    	t.string :email

    	t.string :title
    	t.string :ride_option

    	t.date :birthdate

    	t.string :primary_phone
    	t.string :secondary_phone

      t.timestamps
    end
  end
end
