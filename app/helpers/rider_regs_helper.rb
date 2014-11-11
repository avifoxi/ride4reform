module RiderRegsHelper

	def month_names_nums
		date_num_arr = [] 
		Date::MONTHNAMES[1..12].each_with_index do |el, i| 
			date_num_arr << [el, i+1] 
		end
		date_num_arr
	end

	def birth_year_range
		(Time.now.year - 80)..(Time.now.year - 16)
	end

	def birth_day_range
		1..31
	end

  def setup_mailing_addy(rider_reg)
    rider_reg.mailing_address ||= MailingAddress.new
    rider_reg
  end


  def correct_terms_for_ride_option(rider_reg)
  	html = ''
  	
  	case rider_reg.ride_option
			when 'Original Track'
			  html << "<p>Disclaimer: Each participant agrees to examine and use the bicycle and, where appropriate, any other equipment supplied, at his/her own risk, and shall be in all respects responsible for his/her own safety.  Each participant agrees that neither the Israel Movement for Reform and Progressive Judaism nor their employees or agents will be held responsible for any accidents, injury, death, loss or damage to personal affects, whatsoever.</p>
					<p>Fundraising: In order to participate in this event, you must raise the minimum sponsorship prior to March 2, 2015.  If you are unable to participate in the event for any reason, all donations received by you should nevertheless be sent to the Israel Movement for Reform and Progressive Judaism and will be allocated to the total sponsorship of the event. </p>
					<p>Age: Minimum age of entry is 18 unless accompanied by a parent or legal guardian in which case the minimum age is 17. A Parent or legal guardian must accompany minors at all times.</p>
					<p>Helmets: Must be worn for safety reasons during the ride.</p>
					<p>Accommodation: Rooms will be shared wherever possible with someone of your choice – numbers per room will vary subject to location. Room standard is youth hostel, or better, when possible.</p>
					<p>The organizers reserve the right to change the route and/or accommodations should the necessity arise.</p>"
			when 'Light Track'
			  html << "<p>Disclaimer: Each participant agrees to examine and use the bicycle and, where appropriate, any other equipment supplied, at his/her own risk, and shall be in all respects responsible for his/her own safety.  Each participant agrees that neither the Israel Movement for Reform and Progressive Judaism nor their employees or agents will be held responsible for any accidents, injury, death, loss or damage to personal affects, whatsoever.</p>
				<p>Fundraising: In order to participate in this event, you must raise the minimum sponsorship prior to March 2, 2015.  If you are unable to participate in the event for any reason, all donations received by you should nevertheless be sent to the Israel Movement for Reform and Progressive Judaism and will be allocated to the total sponsorship of the event. </p>
				<p>Age: Minimum age of entry is 18 unless accompanied by a parent or legal guardian in which case the minimum age is 17. A Parent or legal guardian must accompany minors at all times.</p>
				<p>Helmets: Must be worn for safety reasons during the ride.</p>
				<p>Accommodation: Rooms will be shared wherever possible with someone of your choice – numbers per room will vary subject to location. Room standard is youth hostel, or better, when possible.</p>
				<p>The organizers reserve the right to change the route and/or accommodations should the necessity arise. </p>"
			when ('Hiking/Riding' || 'Hiking')
				html << '<p>Disclaimer: Each participant agrees to examine any equipment supplied, at his/her own risk, and shall be in all respects responsible for his/her own safety. Each participant agrees that neither the Israel Movement for Reform and Progressive Judaism nor their employees or agents will be held responsible for any accidents, injury, death, loss or damage to personal affects, whatsoever.</p>
					<p>Fundraising: In order to participate in this event, you must raise the minimum sponsorship prior to March 2, 2015.  If you are unable to participate in the event for any reason, all donations received by you should nevertheless be sent to the Israel Movement for Reform and Progressive Judaism and will be allocated to the total sponsorship of the event. </p>
					<p>Age: Minimum age of entry is 18 unless accompanied by a parent or legal guardian in which case the minimum age is 17. A Parent or legal guardian must accompany minors at all times.</p>
					<p>Accommodation: Rooms will be shared wherever possible with someone of your choice – numbers per room will vary subject to location. Room standard is youth hostel, or better, when possible.</p>
					<p>The organizers reserve the right to change the route and/or accommodations should the necessity arise.</p>'
		end
		html.html_safe
  end


  def fiddy_states
  	Array[ ["AK", "Alaska"], 
        ["AL", "Alabama"], 
        ["AR", "Arkansas"], 
        ["AS", "American Samoa"], 
        ["AZ", "Arizona"], 
        ["CA", "California"], 
        ["CO", "Colorado"], 
        ["CT", "Connecticut"], 
        ["DC", "District of Columbia"], 
        ["DE", "Delaware"], 
        ["FL", "Florida"], 
        ["GA", "Georgia"], 
        ["GU", "Guam"], 
        ["HI", "Hawaii"], 
        ["IA", "Iowa"], 
        ["ID", "Idaho"], 
        ["IL", "Illinois"], 
        ["IN", "Indiana"], 
        ["KS", "Kansas"], 
        ["KY", "Kentucky"], 
        ["LA", "Louisiana"], 
        ["MA", "Massachusetts"], 
        ["MD", "Maryland"], 
        ["ME", "Maine"], 
        ["MI", "Michigan"], 
        ["MN", "Minnesota"], 
        ["MO", "Missouri"], 
        ["MS", "Mississippi"], 
        ["MT", "Montana"], 
        ["NC", "North Carolina"], 
        ["ND", "North Dakota"], 
        ["NE", "Nebraska"], 
        ["NH", "New Hampshire"], 
        ["NJ", "New Jersey"], 
        ["NM", "New Mexico"], 
        ["NV", "Nevada"], 
        ["NY", "New York"], 
        ["OH", "Ohio"], 
        ["OK", "Oklahoma"], 
        ["OR", "Oregon"], 
        ["PA", "Pennsylvania"], 
        ["PR", "Puerto Rico"], 
        ["RI", "Rhode Island"], 
        ["SC", "South Carolina"], 
        ["SD", "South Dakota"], 
        ["TN", "Tennessee"], 
        ["TX", "Texas"], 
        ["UT", "Utah"], 
        ["VA", "Virginia"], 
        ["VI", "Virgin Islands"], 
        ["VT", "Vermont"], 
        ["WA", "Washington"], 
        ["WI", "Wisconsin"], 
        ["WV", "West Virginia"], 
        ["WY", "Wyoming"] ]
  end


end


