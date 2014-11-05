case Rails.env
when "development"


  10.times do 
    User.create(title: User.titles.sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: Faker::Internet.password)
  end


  users = User.all.to_a
  amounts = (500..5000).to_a
  

  10.times do 
    user = users.pop
    address = MailingAddress.create(line1: Faker::Address.street_address, line2: Faker::Address.secondary_address, city: Faker::Address.city, state: Faker::Address.state, zip: Faker::Address.zip)
    RiderReg.create(rider: user, ride_option: RiderReg.ride_options.sample, birthdate: Date.new(1982,4,19), primary_phone: Faker::PhoneNumber.phone_number, secondary_phone: Faker::PhoneNumber.phone_number, goal: amounts.sample, bio: Faker::Hacker.say_something_smart, accept_terms: [true,false].sample, mailing_address: address)
  end


  paypal_ids = ["PAY-6TE47689SH116733BKQZORSA", "PAY-07051515UV165014UKQ2AMCY", "PAY-40154047YX603662UKQ2ANMY", "PAY-8CC51583WB547212YKQ2YWSQ", "PAY-5PJ06320FR509540HKQ6SZTI"]
  amounts = (10..100).to_a
  users = User.all.to_a


  10.times do
    address = MailingAddress.create(line1: Faker::Address.street_address, line2: Faker::Address.secondary_address, city: Faker::Address.city, state: Faker::Address.state, zip: Faker::Address.zip)    
    receipt = Receipt.create(mailing_address: address, amount: amounts.sample, paypal_id: paypal_ids.sample, user: users.sample)
    Donation.create(receipt: receipt, rider: users.sample)
  end


  avi = User.create(title: User.titles.sample, first_name: 'Avi', last_name: 'FR', email: 'email@email.com', password: 'password')
  alan = User.create(title: User.titles.sample, first_name: 'Alan', last_name: 'C', email: 'email2@email.com', password: 'password')
  

when "production"
   

end