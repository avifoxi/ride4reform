class User < ActiveRecord::Base
  has_many :donations_received, :foreign_key => "rider_id", :class_name => "Donation"
  has_many :donations_given, :foreign_key => "donor_id", :class_name => "Donation"

  has_one :rider_reg, :foreign_key => :rider_id
  has_one :admin_reg

  has_one :address, :as => :addressable
  accepts_nested_attributes_for :address

  TITLES = ['Mr', 'Ms', 'Dr', 'Rabbi', 'Cantor', 'Chazzan', 'Educator', 'None']

  def self.titles 
  	TITLES
  end

  def admin?
  	self.admin_reg ? true : false
  end

  def rider?
  	self.rider_reg ? true : false
  end



end
