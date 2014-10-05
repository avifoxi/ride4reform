class CreateAdminRegs < ActiveRecord::Migration
  def change
    create_table :admin_regs do |t|
    	t.references :user
    	t.string :access_level
      t.timestamps
    end
  end
end
