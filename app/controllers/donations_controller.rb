class DonationsController < ApplicationController

  def index
    ##DEBUG ROUTE TO GET ALL TRANSACTIONS
    p Payment.all.payments.first
  end

  def new
    @rider = RiderReg.find(params[:id])
    @donation = Donation.new
  end


  def create
    mc_pp = PayPalWrapper.new(params)

    if mc_pp.create
      rider_reg = RiderReg.find(params[:id])
      rider = rider_reg.rider

      user = User.find_by_email(params[:email])

      unless user
        user = User.create(first_name: params[:first_name],
                           last_name:  params[:last_name],
                           email:      params[:email],
                           password:   "password")
      end

      # TODO - need to fix name collision with paypal address class
      # address = Address.create(line1:  params[:line1],
      #                          city:   params[:city],
      #                          state:  params[:state],
      #                          zip:    params[:postal_code])

      # receipt = Receipt.create(amount:    params[:total],
      #                          paypal_id: payment.id,
      #                          user:      user,
      #                          address:   address)

      # REMOVE THIS RECEIPT CREATION WHEN ADDRESS IS SORTED OUT
      receipt = Receipt.create(amount:    params[:total],
                               paypal_id: mc_pp.id,
                               user:      user)

      donation = Donation.create(receipt: receipt, rider: rider)

      redirect_to rider_reg_path(rider_reg), :flash => { :thanks_to_donor => user.full_name }
    else
      mc_pp.error
      # TODO - add error page redirect
    end
  end

  def show

  end



end
