class Rider < ActiveRecord::Base
  has_many :donations
  has_many :donors, through: :donations

  has_one :address, :as => :addressable
  accepts_nested_attributes_for :address

  RIDE_OPTIONS = ['Original Track', 'Light Track', 'Hiking', 'Combination Hiking/Riding']

  TITLES = ['Mr', 'Ms', 'Dr', 'Rabbi', 'Cantor', 'Chazzan', 'Educator', 'None']

  def self.ride_options 
  	RIDE_OPTIONS
  end

  def self.titles 
  	TITLES
  end


end
