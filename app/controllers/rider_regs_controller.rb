class RiderRegsController < ApplicationController
	
	def index 
		@riders = RiderReg.all

    respond_to do |format|
      format.html
      format.csv { send_data @riders.as_csv }
    end
	end

	def new
		@rider_reg = RiderReg.new
	end

	def create 
    @rider_reg = RiderReg.new(rider_reg_params)
		@rider_reg.rider = current_user
    @rider_reg.birthdate = birthdate_params
		
    if @rider_reg.save
      @rider_reg.mailing_address.save
			redirect_to rider_regs_terms_path
    else
     p @rider_reg.errors
     render action: 'new'
		end
	end

	def show
		@rider = RiderReg.find(params[:id])
		if @rider.donors.count > 0
      @donors = @rider.donors
    end
	end

	def edit
		@rider_reg = RiderReg.find(params[:id])
		unless current_user == @rider_reg.rider
			redirect_to root_url
		end    
	end

	def update
		rider_reg = RiderReg.find(params[:id])
		
		if rider_reg.update_attributes(rider_reg_params)
			redirect_to rider_reg
		else
			# notify error
		end
	end

	def terms_of_entry
		@rider = current_user.rider_reg
	end

	def accept_terms
		@rider = current_user.rider_reg
		@rider.update_attributes(accept_terms: params[:accept_terms])
		redirect_to rider_regs_fee_path
	end

  def registration_fee
    @rider_reg = current_user.rider_reg
    @receipt = Receipt.new
  end

  def pay_fee
    payment = PayPalWrapper.new(params)

    if payment.create
      user = current_user

      # Two address creations so one can be assigned to the receipt
      # and one can be assigned to the rider registration
      address1 = MailingAddress.create(line1:  params[:line1],
                                       line2:  params[:line2],
                                       city:   params[:city],
                                       state:  params[:state],
                                       zip:    params[:postal_code])

      address2 = MailingAddress.create(line1:  params[:line1],
                                       line2:  params[:line2],
                                       city:   params[:city],
                                       state:  params[:state],
                                       zip:    params[:postal_code])

      receipt = Receipt.create(amount:          params[:total],
                               paypal_id:       payment.id,
                               user:            user,
                               mailing_address: address1)

      rider_reg = user.rider_reg
      rider_reg.paid = true
      rider_reg.mailing_address = address2
      rider_reg.save

      redirect_to rider_reg_path(rider_reg)
    else
      payment.error
      # TODO - add error page redirect
    end
  end

	private 

	def rider_reg_params
    params.require(:rider_reg).permit(:ride_option, :primary_phone, :secondary_phone, :birthdate, :goal, :bio, :accept_terms, :photo, :mailing_address_attributes => [:line1, :line2, :city, :state, :zip])
  end

  def birthdate_params
    month = params["rider_reg_month"].to_i
    year = params["rider_reg_year"].to_i
    day = params["rider_reg_day"].to_i
    Date.new(year,month,day)
  end
end
