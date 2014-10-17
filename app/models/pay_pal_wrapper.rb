class PayPalWrapper
    
	def initialize(params)
		@params = params
		connect_to_paypal		

	end

	def connect_to_paypal
		case Rails.env
			when "test"
				# do nothing, mock
			when "development"
				PayPal::SDK::REST.set_config(
		      :mode => "sandbox", # "sandbox" or "live"
		      :client_id => ENV['PAYPAL_CLIENT_ID'],
		      :client_secret => ENV['PAYPAL_SECRET'])
			when "production"
				PayPal::SDK::REST.set_config(
		      :mode => "sandbox", # for the time being -- don't wanna unnecessarily charge yet
		      :client_id => ENV['PAYPAL_CLIENT_ID'],
		      :client_secret => ENV['PAYPAL_SECRET'])
			end
	end


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



end