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


	private 

	def rider_reg_params
    params.require(:rider_reg).permit(:ride_option, :primary_phone, :secondary_phone, :birthdate, :goal, :bio)
  end

end
