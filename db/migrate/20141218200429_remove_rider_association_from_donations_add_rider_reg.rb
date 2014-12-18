class RemoveRiderAssociationFromDonationsAddRiderReg < ActiveRecord::Migration
  def change
  	remove_column :donations, :rider_id, :integer
  	add_column :donations, :rider_reg_id, :integer
  end
end
