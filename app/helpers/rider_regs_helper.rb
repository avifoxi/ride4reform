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
end


