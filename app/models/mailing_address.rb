class MailingAddress < ActiveRecord::Base
	belongs_to :addressable, :polymorphic => true

	def self.valid_types
		["RiderReg", "Receipt"]
	end

end
