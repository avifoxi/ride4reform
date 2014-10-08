class RiderRegsController < ApplicationController
	
	def index 
		@riders = RiderReg.all
	end

	def new
		@rider_reg = RiderReg.new
		@user = current_user
	end

	def create 
		rider_reg = RiderReg.new(rider_reg_params)
		p rider_reg
	end


	private 

	def rider_reg_params
    params.require(:rider_reg).permit(:ride_option, :primary_phone, :secondary_phone, :birthdate)
  end

end
