class AdminsController < ApplicationController
	before_action :require_admin

	def index

	end

	def new
		@current_admins = User.where(admin: true)
		@users = User.where(admin: false)
 		@admin = User.new
	end

	def create
		if params[:user_id]
			@admin = User.find(params[:user_id])
		else 
			@admin = User.new(admin_params)
		end

		@admin.admin = true

		if @admin.save
			flash[:notify] = "Successfully created #{@admin.full_name} as Admin"
			redirect_to admin_path
		else
			flash[:error] = @admin.errors
			redirect_to admin_edit_path
		end

	end 

	def destroy
		user = User.find(params[:user_id])
		user.admin = false
		user.save
		redirect_to admin_path
	end
	

	private



	def admin_params
		# refactor for strong params 
		{first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation], title: 'None'}
	end

end
