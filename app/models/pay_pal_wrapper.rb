include PayPal::SDK::REST

class PayPalWrapper
   
  attr_accessor :payment, :amount  

	def initialize(address, cc_info, amount)
		@address = address
		@cc_info = cc_info
		@amount = amount
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

	def errors

		if Rails.env == 'test'
			'error'
		else
			if @payment.error 
				issues = @payment.error.details.map do |d|
					d.issue
				end
			else
				nil
			end
		end
	end

	private

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
				## TODO --> this must be updated before deploy

				PayPal::SDK::REST.set_config(
		      :mode => "sandbox", 
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
		            :first_name => @cc_info[:first_name],
		            :last_name => @cc_info[:last_name],
		            :billing_address => {
		              :line1 => @address[:line1],
		              :city => @address[:city],
		              :state => @address[:state],
		              :postal_code => @address[:zip],
		              :country_code => "US" }}}]},
		      :transactions => [{
		        :item_list => {
		          :items => [{
		            :name => "item",
		            :sku => "item",
		            :price => "%.2f" % @amount,
		            :currency => "USD",
		            :quantity => 1 }]},
		        :amount => {
		          :total => "%.2f" % @amount,
		          :currency => "USD" },
		        :description => "This is the payment transaction description." }]})

		##### TODO --> this will need separate protocol but for now, same as dev
			# when "production" 

			when  "production"
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
		            :first_name => @cc_info[:first_name],
		            :last_name => @cc_info[:last_name],
		            :billing_address => {
		              :line1 => @address[:line1],
		              :city => @address[:city],
		              :state => @address[:state],
		              :postal_code => @address[:zip],
		              :country_code => "US" }}}]},
		      :transactions => [{
		        :item_list => {
		          :items => [{
		            :name => "item",
		            :sku => "item",
		            :price => "%.2f" % @amount,
		            :currency => "USD",
		            :quantity => 1 }]},
		        :amount => {
		          :total => "%.2f" % @amount,
		          :currency => "USD" },
		        :description => "This is the payment transaction description." }]})
		end

	end




end