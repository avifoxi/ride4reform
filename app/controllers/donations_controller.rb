class DonationsController < ApplicationController
  include PayPal::SDK::REST

  def new
    @donation = Payment.new
  end
end
