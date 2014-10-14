class DonationsController < ApplicationController
  include PayPal::SDK::REST

  def index
    ##DEBUG ROUTE TO GET ALL TRANSACTIONS
    p Payment.all.payments.first
  end

  def new

    @rider = RiderReg.find(params[:id])
    @donation = Donation.new
  end


  def create
    ##DEBUG CODE TO MAKE IT EASIER TO HIT A ROUTE TO TEST TRANSACTION

    PayPal::SDK::REST.set_config(
      :mode => "sandbox", # "sandbox" or "live"
      :client_id => ENV['PAYPAL_CLIENT_ID'],
      :client_secret => ENV['PAYPAL_SECRET'])

    # Build Payment object
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

    # Create Payment and return the status(true or false)
    if payment.create
      payment.id     # Payment Id

      user = User.find_by(email: params[:email])
      rider = Rider.find(params[:id])

      unless user
        user = User.create()
        # name 
        # email 

        ### Address
        address = Address.create(line1: params[:line1],
                                 city:  params[:city],
                                 state: params[:state],
                                 zip:   params[:zip])

        ### Donation
        donation = Donation.create(amount:  params[:total],
                                   paypal:  payment.id,
                                   user:    user,
                                   rider:   rider,
                                   address: address)



      ## what info do we now need to save to DB  ? 
      redirect_to donation_path()
    else
      payment.error  # Error Hash
    end
  end

  def show

  end



end
