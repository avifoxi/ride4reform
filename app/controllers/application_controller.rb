class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	
	# before_filter :configure_permitted_parameters, if: :devise_controller?
  
	# def after_sign_up_path_for(:user)
 #    new_user_rider_reg(:user)
	# end

  protected



  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name, :title]
  # end



end
