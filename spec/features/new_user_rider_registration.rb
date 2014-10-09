require 'rails_helper'

describe "the signin process", :type => :feature do
  # before :each do
  #   User.make(:email => 'user@example.com', :password => 'caplin')
  # end

  it "allows new user to create basic account" do
    visit '/'
    click_button 'Register Now!'
    expect(page).to have_content 'Success'
  end
end