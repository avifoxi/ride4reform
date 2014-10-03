class Rider < ActiveRecord::Base
  has_many :donations
  has_many :donors, through: :donations

  RIDE_OPTIONS = ['Original Track', 'Light Track', 'Hiking', 'Combination Hiking/Riding']

  def self.ride_options 
  	RIDE_OPTIONS
  end


end
