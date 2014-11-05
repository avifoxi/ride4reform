class AdminController < ApplicationController
	before_action :require_admin

	def index

	end

	def new
		@current_admins = User.where(admin: true)
		@users = User.where(admin: false)
 		@admin = User.new
	end

	def create
		p params
	end 
	

	private

	def require_admin
		unless current_user.try(:admin?)
			flash[:error] = 'You must be an admin to access this page.'
			redirect_to root_url
		end
	end

end
