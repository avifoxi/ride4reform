class Donation < ActiveRecord::Base
	belongs_to :rider, :class_name => "User"
	belongs_to :receipt

  delegate :amount, :user, to: :receipt, allow_nil: true, prefix: false

  accepts_nested_attributes_for :receipt

  before_save :update_amount_raised


  protected
   def update_amount_raised
    self.rider.rider_reg.raised += self.receipt.amount
    self.rider.rider_reg.save
   end



	# has_one :address, :as => :addressable
 #  accepts_nested_attributes_for :address

 #  def billing_address 
 #  	if @distinct_billing_address
 #  		self.address
 #  	else
 #  		self.donor.address
 #  	end
 #  end


end
