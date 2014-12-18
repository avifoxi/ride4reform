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
    

    # p '#' * 50
    # p 'search for donor in Users OR create new'
    # p @donor
    # p '#' * 50

    # p '#' * 50
    # p 'search for RiderReg by id'
    # p @rider_reg 
    # p '#' * 50
  

    # First -- find user if user and return
    payment = PayPalWrapper.new(donor_address, cc_info, amount)

    if payment.create

      @donor = User.find_by(email: donor_email)
      unless @donor 
        @donor = User.create(email: donor_email, password: 'donor_not_yet_rider', first_name: cc_info['first_name'], last_name: cc_info['last_name'])
      end

      @rider_reg = RiderReg.find(params[:id])

      @receipt = Receipt.create(amount:            amount,
                               paypal_id:         payment.id,
                               user:              user )

      unless donation_params['receipt_attributes']['reference_user_address'].to_b
        @receipt.update_attributes(reference_user_address: false)
        @receipt.mailing_address.create(donor_address)
      end
      
      @donation = Donation.create(receipt: @receipt, rider_reg: @rider_reg, anonymous: donation_params['anonymous'], message_to_rider: donation_params['message_to_rider'] )

      # UserMailer.donation_receipt(donation).deliver

      redirect_to rider_reg_path(@rider_reg), :flash => { :thanks_to_donor => user.full_name }
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

    def donor_email
      donation_params['receipt_attributes']['user_attributes']['email']
    end

    def donor_address 
      if donation_params['receipt_attributes']['reference_user_address'].to_b
        User.find_by(email: donor_email).mailing_address
      else
        MailingAddress.create(donation_params['receipt_attributes']['mailing_address_attributes'])
      end
    end

    def amount 
      donation_params['receipt_attributes']['amount']
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
