class RiderReg < ActiveRecord::Base
	
	belongs_to :rider, :class_name => "User"
	delegate :first_name, :last_name, :title, to: :rider, allow_nil: true, prefix: false

	has_many :donations_received, through: :rider
	has_one :address, through: :rider

  RIDE_OPTIONS = ['Original Track', 'Light Track', 'Hiking', 'Combination Hiking/Riding']

  def self.ride_options 
  	RIDE_OPTIONS
  end

  def percent_of_goal
  	perc = (self.raised.to_f / self.goal.to_f).round(2) * 100
  	perc.to_i.to_s + '%'
  end

  def full_name
    self.title + ' ' + self.first_name + ' ' + self.last_name
  end
  
end
