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
			redirect_to rider_reg
		end

	end

	def show
		@rider = RiderReg.find(params[:id])
		@donors = @rider.donors
		@address = @donor.address
	end


	private 

	def rider_reg_params
    params.require(:rider_reg).permit(:ride_option, :primary_phone, :secondary_phone, :birthdate, :goal)
  end

end
