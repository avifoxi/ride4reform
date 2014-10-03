class Rider < ActiveRecord::Base
  has_many :donations
  has_many :donors, through: :donations

  RIDE_OPTIONS = ['Original Track', 'Light Track', 'Hiking', 'Combination Hiking/Riding']

  TITLES = ['Mr', 'Ms', 'Dr', 'Rabbi', 'Cantor', 'Chazzan', 'Educator', 'None']

  def self.ride_options 
  	RIDE_OPTIONS
  end

  def self.titles 
  	TITLES
  end


end
