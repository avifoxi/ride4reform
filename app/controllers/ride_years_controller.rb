class RideYearsController < ApplicationController
  before_action :require_admin

  def index
    @ride_years = RideYear.all.order(year: :desc)
  end

  def new
    @ride_year = RideYear.new
  end

  def create
    RideYear.create(ride_year_params)
    redirect_to ride_years_path
  end

  def edit
    @ride_year = RideYear.find(params["id"])
  end

  def update
    ride_year = RideYear.find(params["id"])
    ride_year.update(ride_year_params)
    redirect_to ride_years_path
  end

  def destroy
    ride_year = RideYear.find(params["id"])
    ride_year.destroy
    redirect_to ride_years_path
  end

  private 

  def ride_year_params
    params.require(:ride_year).permit(:year, :registration_fee, :registration_fee_early, :min_rider_fundraise, :early_bird_cutoff)
  end

  # def require_admin
  #   unless current_user.try(:admin?)
  #     flash[:error] = 'You must be an admin to access this page.'
  #     redirect_to root_url
  #   end
  # end 
end
