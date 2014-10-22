class RiderRegsController < ApplicationController
	
	def index 
		@riders = RiderReg.all
	end

	def new
		@rider_reg = RiderReg.new
	end

	def create 
		rider_reg = RiderReg.new(rider_reg_params)
		rider_reg.rider = current_user

		if rider_reg.save
			redirect_to rider_regs_terms_path
		end
	end

	def show
		@rider = RiderReg.find(params[:id])
		@donors = @rider.donors
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
    mc_pp = PayPalWrapper.new(params)

    if mc_pp.create
      rider_reg = current_user.rider_reg
      rider_reg.paid = true
      rider_reg.save

      user = current_user

      receipt = Receipt.create(amount:    params[:total],
                               paypal_id: mc_pp.id,
                               user:      user)

      redirect_to rider_reg_path(rider_reg)
    else
      mc_pp.error
      # TODO - add error page redirect
    end
  end

	private 

	def rider_reg_params
    params.require(:rider_reg).permit(:ride_option, :primary_phone, :secondary_phone, :birthdate, :goal, :bio, :accept_terms)
  end

end
