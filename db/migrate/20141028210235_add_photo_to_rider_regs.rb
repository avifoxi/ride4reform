class AddPhotoToRiderRegs < ActiveRecord::Migration
	def self.up
    add_attachment :rider_regs, :photo
  end

  def self.down
    remove_attachment :rider_regs, :photo
  end  
	
end
