require 'rails_helper'
require_relative 'feature_helper_methods'

describe "the donation process" do
	## call helper method to sign up and register a rider. now, just call lower method
    it "unregisterd user donates to registered rider" do
        register_new_rider_logout
        click_link 'Donate Now!'
        expect(page).to have_content 'Rider Test'
        click_link 'Donate Now!'
        select('Visa', :from=> 'Credit Card Type')
        fill_in('Credit Card Number', :with => '4417119669820331')
        fill_in('Month (MM)', :with => '11')
        fill_in('Year (YYYY)', :with => '2018')
        fill_in('CVV2', :with => '874')
        fill_in('First Name', :with => 'Unregistered')
        fill_in('Last Name', :with => 'Donor')
        fill_in('Email', :with => 'donor@donor.com')
        fill_in('Address', :with => '123 Donor Blvd')
        fill_in('City', :with => 'Donor')
        fill_in('State', :with => 'New York')
        fill_in('Postal Code', :with => '11225')
        fill_in('Donation', :with => '100')
        click_button 'Donate'

        expect(page).to have_content 'Thank you for your generous'
        expect(page).to have_content 'has raised 10% of their goal'
    end
end