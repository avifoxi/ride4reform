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
    @rider_reg.rider = current_user

	end

	def create 
    ## don't want to commit to DB before kosher, copy from strong params and remove user id info
    p_copy = rider_reg_params.dup
    p_copy.delete('rider_attributes')

    @rider_reg = RiderReg.new(p_copy)
	
    if @rider_reg.save
      ## from strong params - this updates mailing address, must do after RR entry made in DB
      @rider_reg.rider = current_user
      @rider_reg.birthdate = birthdate_params
      @rider_reg.update_attributes(rider_reg_params)

      ## TODO -- what if there is an error in mailing address ? do we need error handling?
      # @rider_reg.rider.mailing_address.save
			redirect_to rider_regs_terms_path
    else
     # @rider_reg.errors
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
    @current_ride_year = RideYear.current
    @rider_reg = current_user.rider_reg
    @db_address = @rider_reg.mailing_address
    @receipt = Receipt.new
  end

  def pay_fee
    
    if params["reference_user_address"].to_b
      address = current_user.mailing_address
    else
      address = MailingAddress.new(rider_reg_params['rider_attributes']['mailing_address_attributes'])
    end

    cc_info = rider_reg_params['rider_attributes']['receipt'] 
    # p '%%'*50
    amount = RideYear.current_fee

    payment = PayPalWrapper.new(address, cc_info)




    # if payment.create
    #   user = current_user


      # receipt = Receipt.create(amount:          params[:total],
      #                          paypal_id:       payment.id,
      #                          user:            user,
      #                          mailing_address: address1)

      # rider_reg = user.rider_reg
      # rider_reg.paid = true
      # rider_reg.mailing_address = address2
      # rider_reg.save

    #   redirect_to rider_reg_path(rider_reg)
    # else
    #   payment.error
    #   # TODO - add error page redirect
    # end
  end

	private 

	def rider_reg_params
    params.require(:rider_reg).permit(:ride_option, :primary_phone, :secondary_phone, :birthdate, :goal, :bio, :accept_terms, :photo, 
      :rider_attributes =>
        [
          :id, 
          :mailing_address_attributes => [:line1, :line2, :city, :state, :zip],
          :receipt => [:type, :credit_card, :month, :expire_year, :cvv2, :first_name, :last_name]  
        ]
      )
  end

  def birthdate_params
    month = params["rider_reg_month"].to_i
    year = params["rider_reg_year"].to_i
    day = params["rider_reg_day"].to_i
    Date.new(year,month,day)
  end
end
