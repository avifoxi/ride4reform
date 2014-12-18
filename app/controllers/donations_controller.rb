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
    # {
    #   "utf8"=>"✓", 
    #   "authenticity_token"=>"q7Xts374F44nI7qc3vD//i30KOD5ulk1GGx81FfX6EU=", 
    #   "donation"=>
    #     {"anonymous"=>"false", "message_to_rider"=>"asfdlaksjdflaskdjf\r\n", 
    #       "receipt_attributes"=>
    #         {
    #           "amount"=>"20.0", "reference_user_address"=>"", 
    #           "user_attributes"=>
    #             {"email"=>"foox@blsfdj.com"}, 
    #           "mailing_address_attributes"=>
    #             {"line1"=>"1234", "line2"=>"erwer", "city"=>"werqwer", "state"=>"Maine", "zip"=>"1234"}
    #           }
    #       }, 
    #       "type"=>"visa", "credit_card"=>"1232341234213412", "expire_month"=>"1", "expire_year"=>"2016", "cvv2"=>"1234", "first_name"=>"flee", "last_name"=>"badfsd", "commit"=>"Submit", "controller"=>"donations", "action"=>"create", "id"=>"5"
    # }
    

    # @rider_reg = User.find(params[:id])
    p '$'*50
    puts 'regular params, unfiltered: '
    p params
    p '$'*50

    p '$'*50
    puts 'donation_params: '
    p donation_params
    p '$'*50
    # donation_params
    # @donor = User.find_by(email: params[:email])
    # unless @donor 
    #   @donor = User.new(email: params[:email], password: 'donor_not_yet_rider')
    # end

    # p '#' * 50
    # p 'search for donor in Users'
    # p @donor
    # p '#' * 50
    # respond_to do |format|
      # if @rider_reg.update_attributes(rider_reg_params)
        # format.html { redirect_to @rider_reg, notice: 'rider_reg was successfully updated.' }
        # format.json { @donor }
        # added:
        # format.js   { render action: 'show', status: :created, location: @rider_reg }
      # else
      #   format.html { render action: 'new' }
      #   format.json { render json: @rider_reg.errors, status: :unprocessable_entity }
      #   # added:
      #   format.js   { render json: @rider_reg.errors, status: :unprocessable_entity }
      # end
    # end

    # First -- find user if user and return
    # payment = PayPalWrapper.new(params)

    # if payment.create
    #   rider_reg = RiderReg.find(params[:id])
    #   rider = rider_reg.rider

    #   user = User.find_by_email(params[:email])

    #   unless user
    #     user = User.create(first_name: params[:first_name],
    #                        last_name:  params[:last_name],
    #                        email:      params[:email],
    #                        password:   "password")
    #   end

    #   address = MailingAddress.create(line1:  params[:line1],
    #                                   line2:  params[:line2],
    #                                   city:   params[:city],
    #                                   state:  params[:state],
    #                                   zip:    params[:postal_code])

    #   receipt = Receipt.create(amount:            params[:total],
    #                            paypal_id:         payment.id,
    #                            user:              user,
    #                            mailing_address:   address)

    #   donation = Donation.create(receipt: receipt, rider: rider)

    #   UserMailer.donation_receipt(donation).deliver

    #   redirect_to rider_reg_path(rider_reg), :flash => { :thanks_to_donor => user.full_name }
    # else
    #   payment.error
    #   # TODO - add error page redirect
    # end
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

end
