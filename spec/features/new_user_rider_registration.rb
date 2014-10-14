require 'rails_helper'

describe "the signin process" do


  # before :each do
  #   User.make(:email => 'user@example.com', :password => 'caplin')
  # end

  it "allows new user to create basic account" do
    visit root_url
    click_link 'Register Now!'
    expect(page).to have_content 'Sign Up'

    select('Mr', :from => 'Title')
    fill_in('First name', :with => 'Alan')
    fill_in('Last name', :with=> 'Cohen')
    fill_in('Email', :with=> 'alan@test.com')
    fill_in('Password', :with => 'password')
    fill_in('Password confirmation', :with=> 'password')
    click_button 'Sign up'

    expect(page).to have_content 'Please fill out your Rider Registration!'

    select('Original Track', :from=> 'Ride option')
    fill_in('Birthdate', :with=> '05071983')
    fill_in('Primary phone', :with=> '123-456-7890')
    fill_in('Secondary phone', :with=> '098-765-4321')
    fill_in('Goal', :with=> '123456')
    fill_in('Bio', :with=> 'This is my bio.')
    click_button 'Create Rider reg'

    expect(page).to have_content 'Read and Review These Terms of Entry'

    choose('accept_terms_true')
    click_button 'Update Rider reg'

    expect(page).to have_content 'Alan Cohen'
  end
end