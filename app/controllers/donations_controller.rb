class DonationsController < ApplicationController
  # helper RiderReg::RiderRegsHelper

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
    @donation.receipt = Receipt.new
    @donation.receipt.user = User.new
    @donation.receipt.mailing_address = MailingAddress.new
  end

  def donation_queries
    @donor = User.find_by(email: params[:email])
    if @donor
      @mailing_address = @donor.mailing_address.one_liner
    end
    render json: { donor: @donor, mailing_address: @mailing_address}

  end

  def create
    

    
    # p '$'*50
    # puts 'regular params, unfiltered: '
    # p params
    # p '$'*50

    # p '$'*50
    # puts 'donation_params: '
    # p donation_params
    # p '$'*50

    # cc_info

    # p '$'*50
    # puts 'cc_info private method: '
    # p cc_info
    # p '$'*50
    # donation_params
    email = donation_params['receipt_attributes']['user_attributes']['email']
    
    @donor = User.find_by(email: email)
    unless @donor 
      @donor = User.new(email: email, password: 'donor_not_yet_rider', first_name: cc_info['first_name'], last_name: cc_info['last_name'])
    end

    # p '#' * 50
    # p 'search for donor in Users OR create new'
    # p @donor
    # p '#' * 50

    @rider_reg = RiderReg.find(params[:id])
    # p '#' * 50
    # p 'search for RiderReg by id'
    # p @rider_reg 
    # p '#' * 50
  

    # First -- find user if user and return
    payment = PayPalWrapper.new(donation_address, cc_info, amount)

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

  private 
    def donation_params
      params.require(:donation).permit(
        :anonymous, :message_to_rider, 
        :receipt_attributes =>
          [
            :amount, :reference_user_address, 
            :user_attributes => 
              [:email],
            :mailing_address_attributes => 
              [
                :line1, :line2, :city, :state, :zip
              ]
          ]
      )
    end

    def donation_address 
      donation_params['receipt_attributes']['mailing_address_attributes']
    end

    def cc_info
      {
        :type => params[:type],
        :number => params[:number],
        :expire_month => params[:expire_month],
        :expire_year => params[:expire_year],
        :cvv2 => params[:cvv2],
        :first_name => params[:first_name],
        :last_name => params[:last_name]
      }
    end

end
