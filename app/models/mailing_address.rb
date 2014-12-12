class MailingAddress < ActiveRecord::Base
	belongs_to :addressable, :polymorphic => true

	def self.valid_types
		["RiderReg", "Receipt"]
	end

	def one_liner
		o_l = self.line1 + ' ' 
		if self.line2 
			o_l += (self.line2 + ' ')
		end
		o_l + self.city + ' ' + self.zip
	end

end

