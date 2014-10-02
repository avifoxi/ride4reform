class Donation < ActiveRecord::Base
	belongs_to :rider
	belongs_to :donor

end
