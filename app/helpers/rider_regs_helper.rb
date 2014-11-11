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


