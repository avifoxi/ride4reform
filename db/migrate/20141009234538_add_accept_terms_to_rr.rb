class AddAcceptTermsToRr < ActiveRecord::Migration
  def change
  	change_table :rider_regs do |t|
  		t.boolean :accept_terms, :default => false
  	end
  end
end
