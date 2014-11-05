class AdminController < ApplicationController
	before_action :require_admin

	def index

	end

	private

	def require_admin
		unless current_user.try(:admin?)
			flash[:error] = 'You must be an admin to access this page.'
			redirect_to root_url
		end
	end

end
