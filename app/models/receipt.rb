class Receipt < ActiveRecord::Base
	belongs_to :user
	# belongs_to :rider_reg, as: :registration_receipt
	has_one :mailing_address, :as => :addressable
  
end
