class Donation < ActiveRecord::Base
	belongs_to :rider, :class_name => "User"
	belongs_to :donor, :class_name => "User"

	has_one :address, :as => :addressable
  accepts_nested_attributes_for :address

  def billing_address 
  	if @distinct_billing_address
  		self.address
  	else
  		self.donor.address
  	end
  end


end
