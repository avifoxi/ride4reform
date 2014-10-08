class RiderRegsController < ApplicationController
	
	def index 
		@riders = RiderReg.all
	end

	def new
		@rider_reg = RiderReg.new
	end

end
