class Receipt < ActiveRecord::Base
	belongs_to :user
	has_one :mailing_address, :as => :addressable
  
  accepts_nested_attributes_for :user, :mailing_address
  
	def get_mailing_address
		if self.reference_user_address
			self.user.mailing_address
		else
			self.mailing_address
		end
	end

	# perhaps this should move to the model? or keep in controller?
	# def set_mailing_address(params_hash)
	# 	if self.reference_user_address
	# 		m = MailingAddress.new(params_hash)
	# 		if m.save
	# 			self.user.mailing_address = m
	# 		else
	# 			m.errors
	# 		end
	# 	else
	# 		m = MailingAddress.new(params_hash)
	# 		if m.save
	# 			self.mailing_address = m
	# 		else
	# 			m.errors
	# 		end
	# 	end
	# end

end
