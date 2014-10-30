def register_new_rider_logout
  visit '/'
  click_link 'Register Now!'
  expect(page).to have_content 'Sign Up'

  select('Mr', :from => 'Title')
  fill_in('First name', :with => 'Rider')
  fill_in('Last name', :with=> 'Test')
  fill_in('Email', :with=> 'rider@test.com')
  fill_in('Password', :with => 'password')
  fill_in('Password confirmation', :with=> 'password')
  click_button 'Sign up'

  expect(page).to have_content 'Please fill out your Rider Registration!'

  select('Original Track', :from=> 'Ride option')
  fill_in('Birthdate', :with=> '05071983')
  fill_in('Primary phone', :with=> '123-456-7890')
  fill_in('Secondary phone', :with=> '098-765-4321')
  fill_in('Goal', :with=> '1000')
  fill_in('Bio', :with=> 'This is my bio.')
  click_button 'Create Rider reg'

  expect(page).to have_content 'Read and Review These Terms of Entry'

  choose('accept_terms_true')
  click_button 'Update Rider reg'

  expect(page).to have_content 'Registration Fee'
  select('Visa', :from => 'Credit Card Type:')
  fill_in('Credit Card Number:', :with=> '05071983')
  fill_in('Month (MM):', :with=> '05')
  fill_in('Year (YYYY):', :with=> '2017')
  fill_in('CVV2:', :with=> '123')
  fill_in('First Name:', :with=> 'Rider')
  fill_in('Last Name:', :with=> 'Test')
  fill_in('Address 1:', :with=> '1 Rider Row')
  fill_in('City:', :with=> 'Riderstown')
  fill_in('State:', :with=> 'CA')
  fill_in('Postal Code:', :with=> '90035')

  click_button 'Register'

  expect(page).to have_content 'Rider Test'
  expect(page).to have_content 'Edit Your Profile'
  click_link 'Logout' 
end