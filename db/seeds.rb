# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
case Rails.env
when "development"

	15.times do 
		User.create(title: User.titles.sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: Faker::Internet.password )
	end

	users = User.all
	   
	5.times do 
		user = users.pop
		RiderReg.create(rider: user, ride_option: RiderReg.ride_options.sample, )


when "production"
   

end