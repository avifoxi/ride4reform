class RiderReg < ActiveRecord::Base
	
	belongs_to :rider, :class_name => "User"
	has_many :donations_received, through: :rider
	has_one :address, through: :rider

  RIDE_OPTIONS = ['Original Track', 'Light Track', 'Hiking', 'Combination Hiking/Riding']

  def self.ride_options 
  	RIDE_OPTIONS
  end
  
end
