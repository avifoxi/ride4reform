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
    @current_ride_year = RideYear.current
	end

	def create
    ## don't want to commit to DB before kosher, copy from strong params and remove user id info
    p_copy = rider_reg_params.dup
    p_copy.delete('rider_attributes')

    @rider_reg = RiderReg.new(p_copy)
    if @rider_reg.save
      ## from strong params - this updates mailing address, must do after RR entry made in DB
	      @rider_reg.update_attributes(rider: current_user, birthdate: birthdate_params)
	      @rider_reg.update_attributes(rider_reg_params)

				redirect_to rider_regs_terms_path
		else
			# @rider_reg.errors
			render action: 'new'
		end
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
		@rider_reg = current_user.rider_reg
    p params

    respond_to do |format|
      if @rider_reg.update_attributes(rider_reg_params)
        format.html { redirect_to @rider_reg, notice: 'rider_reg was successfully updated.' }
        format.json { render action: 'show', status: :created, location: @rider_reg }
        # added:
        format.js   { render action: 'show', status: :created, location: @rider_reg }
      else
        format.html { render action: 'new' }
        format.json { render json: @rider_reg.errors, status: :unprocessable_entity }
        # added:
        format.js   { render json: @rider_reg.errors, status: :unprocessable_entity }
      end
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
    @mailing_address = MailingAddress.new
    @receipt = Receipt.new
  end



  def pay_fee
    @rider_reg = current_user.rider_reg

    address = cc_address
    cc_info = rider_reg_params['rider_attributes']['receipt']
    amount = RideYear.current_fee
    payment = PayPalWrapper.new(address, cc_info, amount)


    if payment.create
      receipt = Receipt.create(amount:          amount,
                               paypal_id:       payment.id,
                               user:            current_user,
                               reference_user_address: params["reference_user_address"].to_b
                              )
      @rider_reg.update_attributes(paid: true)
      unless params["reference_user_address"].to_b
        receipt.update_attributes(mailing_address: address)
      end

      # @rider_reg.update_attributes()

      redirect_to rider_reg_path(@rider_reg)
    else
      @pay_errors = payment.errors
      @current_ride_year = RideYear.current
      @rider_reg = current_user.rider_reg
      @db_address = @rider_reg.mailing_address
      render rider_regs_fee_path
    end
  end

	private

	def rider_reg_params
    params.require(:rider_reg).permit(:ride_option, :primary_phone, :secondary_phone, :birthdate, :goal, :bio, :accept_terms, :photo
      :rider_attributes =>
        [
          :id,
          :mailing_address_attributes => [:line1, :line2, :city, :state, :zip],
          :receipt => [:type, :credit_card, :month, :expire_year, :cvv2, :first_name, :last_name]
        ],
      :mailing_address => [:line1, :line2, :city, :state, :zip]
    )
  end

	def mailing_address_params
		params.require(:mailing_address).permit(:line1, :line2, :city, :state, :zip)
	end

  def birthdate_params
    month = params["rider_reg_month"].to_i
    year = params["rider_reg_year"].to_i
    day = params["rider_reg_day"].to_i
    Date.new(year,month,day)
  end

  def cc_address
    if params["reference_user_address"].to_b
      current_user.mailing_address
    else
      MailingAddress.new(rider_reg_params['mailing_address'])
    end
  end

end
