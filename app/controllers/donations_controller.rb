class DonationsController < ApplicationController
  include PayPal::SDK::REST

  def index
    ##DEBUG ROUTE TO GET ALL TRANSACTIONS
    p PayPalTestHelper.new('test_pay_dude')
    p Payment.all.payments.first
  end

  def new
    @rider = RiderReg.find(params[:id])
    @donation = Donation.new
  end


  def create
    PayPal::SDK::REST.set_config(
      :mode => "sandbox", # "sandbox" or "live"
      :client_id => ENV['PAYPAL_CLIENT_ID'],
      :client_secret => ENV['PAYPAL_SECRET'])

    payment = Payment.new({
      :intent => "sale",
      :payer => {
        :payment_method => "credit_card",
        :funding_instruments => [{
          :credit_card => {
            :type => "visa",
            :number => "4417119669820331",
            :expire_month => "11",
            :expire_year => "2018",
            :cvv2 => "874",
            :first_name => params[:first_name],
            :last_name => params[:last_name],
            :billing_address => {
              :line1 => params[:line1],
              :city => params[:city],
              :state => params[:state],
              :postal_code => params[:postal_code],
              :country_code => "US" }}}]},
      :transactions => [{
        :item_list => {
          :items => [{
            :name => "item",
            :sku => "item",
            :price => params[:total],
            :currency => "USD",
            :quantity => 1 }]},
        :amount => {
          :total => params[:total],
          :currency => "USD" },
        :description => "This is the payment transaction description." }]})


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
                               paypal_id: payment.id,
                               user:      user)

      donation = Donation.create(receipt: receipt, rider: rider)

      redirect_to rider_reg_path(rider_reg)
    else
      payment.error
      # TODO - add error page redirect
    end
  end

  def show

  end



end
