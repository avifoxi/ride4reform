class RiderRegsController < ApplicationController
	
	def index 
		@riders = RiderReg.all
	end

	def new
	end

end
