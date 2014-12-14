class MailingAddress < ActiveRecord::Base
	belongs_to :addressable, :polymorphic => true

	validates :line1, :city, :state, :zip, presence: true
	validates :city, format: { with: /[a-zA-Z]{3,}/, message: "Please enter a valid City." }
	validates :zip, format: { with: /\d{5}(-+\d{4}|$)/, message: "Valid zip code formats: '12345' or '12345-6789'" }

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
