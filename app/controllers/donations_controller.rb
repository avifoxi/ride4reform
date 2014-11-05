class DonationsController < ApplicationController

  def index
    @donations = Donation.order(:created_at)
  
    respond_to do |format|
      format.html
      format.csv { send_data @donations.as_csv }
    end
  end

  def new
    @rider = RiderReg.find(params[:id])
    @donation = Donation.new
  end


  def create
    payment = PayPalWrapper.new(params)

    if payment.create
      rider_reg = RiderReg.find(params[:id])
      rider = rider_reg.rider

      user = User.find_by_email(params[:email])

      unless user
        user = User.create(first_name: params[:first_name],
                           last_name:  params[:last_name],
                           email:      params[:email],
                           password:   "password")
      end

      address = MailingAddress.create(line1:  params[:line1],
                                      line2:  params[:line2],
                                      city:   params[:city],
                                      state:  params[:state],
                                      zip:    params[:postal_code])

      receipt = Receipt.create(amount:            params[:total],
                               paypal_id:         payment.id,
                               user:              user,
                               mailing_address:   address)

      donation = Donation.create(receipt: receipt, rider: rider)

      UserMailer.donation_receipt(donation).deliver

      redirect_to rider_reg_path(rider_reg), :flash => { :thanks_to_donor => user.full_name }
    else
      payment.error
      # TODO - add error page redirect
    end
  end

  def show

  end

end
