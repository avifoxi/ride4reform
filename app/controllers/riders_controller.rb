class RidersController < ApplicationController

	def index 
	end

	def new
		@rider = Rider.new
	end

end
