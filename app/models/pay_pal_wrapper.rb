include PayPal::SDK::REST

class PayPalWrapper
   
  attr_accessor :payment  

	def initialize(params)
		@params = params
		@payment = nil
		connect_to_paypal		
		fill_new_payment
	end

	def create
		if Rails.env == 'test'
			true
		else
			@payment.create
		end
	end

	def id
		if Rails.env == 'test'
			'1234testid'
		else
			@payment.id
		end
	end

	def error
		if Rails.env == 'test'
			'error'
		else
			@payment.error
		end
	end

	private

	def connect_to_paypal
		case Rails.env
			when "test"
				# do nothing, mock
			when "development"
				# does this step belong in config? 
				
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


	def fill_new_payment
		case Rails.env
			when "test"
				# do nothing, mock
			when "development"
				self.payment = Payment.new({
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
		            :first_name => @params[:first_name],
		            :last_name => @params[:last_name],
		            :billing_address => {
		              :line1 => @params[:line1],
		              :city => @params[:city],
		              :state => @params[:state],
		              :postal_code => @params[:postal_code],
		              :country_code => "US" }}}]},
		      :transactions => [{
		        :item_list => {
		          :items => [{
		            :name => "item",
		            :sku => "item",
		            :price => "%.2f" % @params[:total],
		            :currency => "USD",
		            :quantity => 1 }]},
		        :amount => {
		          :total => "%.2f" % @params[:total],
		          :currency => "USD" },
		        :description => "This is the payment transaction description." }]})

			when "production"
				
		end

	end




end