class Donation < ActiveRecord::Base
	belongs_to :rider_reg #, :class_name => "User"
	belongs_to :receipt

  delegate :amount, :user, to: :receipt, allow_nil: true, prefix: false

  accepts_nested_attributes_for :receipt

  before_save :update_amount_raised


  def self.as_csv
    CSV.generate do |csv|
      columns = ["id", "donor", "email", "address1",
                 "address2", "city", "state", "zip",
                 "rider", "amount", "date"]
      csv << columns

      all.each do |item|
        row = [item.id,
               item.user.full_name,
               item.user.email,
               item.receipt.mailing_address.line1,
               item.receipt.mailing_address.line2,
               item.receipt.mailing_address.city,
               item.receipt.mailing_address.state,
               item.receipt.mailing_address.zip,
               item.rider.full_name,
               item.amount,
               item.created_at]
        csv << row
      end
    end
  end


  protected
   def update_amount_raised
    self.rider_reg.raised += self.receipt.amount
    self.rider_reg.save
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
