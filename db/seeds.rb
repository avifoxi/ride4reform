case Rails.env
when "development"

	User.create(title: User.titles.sample, first_name: 'Avi', last_name: 'FR', email: 'email@email.com', password: 'password' )

	User.create(title: User.titles.sample, first_name: 'Alan', last_name: 'C', email: 'email2@email.com', password: 'password' )

	15.times do 
		User.create(title: User.titles.sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: Faker::Internet.password )
	end

	users = User.all.to_a
	amounts = (500..5000).to_a
	   

	5.times do 
		user = users.pop
		RiderReg.create(rider: user, ride_option: RiderReg.ride_options.sample, birthdate: Date.new(1982,4,19), goal: amounts.sample, raised: amounts.sample )
	end

	donors = (0..9).to_a
	tf = [true, false]

	20.times do 
		Donation.create(amount: amounts.sample, donor: users.sample, rider: RiderReg.all.sample.rider)
	end


when "production"
   

end