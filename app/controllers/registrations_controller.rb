class RegistrationsController < Devise::RegistrationsController

  protected
    def after_sign_up_path_for(user)
      new_user_rider_reg_path(current_user)
    end

	private
 
	  def sign_up_params
	    params.require(:user).permit(:first_name, :last_name, :title, :email, :password, :password_confirmation)
	  end
	 
	  def account_update_params
	    params.require(:user).permit(:first_name, :last_name, :title, :email, :password, :password_confirmation)
	  end

end
