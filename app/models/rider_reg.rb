class RiderReg < ActiveRecord::Base
	
	belongs_to :rider, :class_name => "User"
	delegate :first_name, :last_name, :title, :full_name, to: :rider, allow_nil: true, prefix: false

	has_many :donations_received, through: :rider
  has_one :address, :as => :addressable

  RIDE_OPTIONS = ['Original Track', 'Light Track', 'Hiking', 'Combination Hiking/Riding']

  def self.ride_options 
  	RIDE_OPTIONS
  end

  def percent_of_goal
  	perc = (self.raised.to_f / self.goal.to_f).round(2) * 100
  	perc.to_i.to_s + '%'
  end

  def donors
    donor_arr = []
    self.donations_received.each do |d|
      donor_arr << d.donor
    end
    donor_arr
  end
  
end
