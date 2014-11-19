class MailingAddress < ActiveRecord::Base
	belongs_to :addressable, :polymorphic => true

	def self.valid_types
		["RiderReg", "Receipt"]
	end

	def one_liner
		self.line1 + ' ' + self.line2 + ' ' + self.city + ' ' + self.zip
	end

end
