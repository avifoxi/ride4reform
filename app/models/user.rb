class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :donations_received, :foreign_key => "rider_id", :class_name => "Donation"
  has_many :donations_given, :foreign_key => "donor_id", :class_name => "Donation"

  has_one :rider_reg, :foreign_key => :rider_id
  
  has_one :admin_reg

  has_many :receipts

  has_one :mailing_address, :as => :addressable
  accepts_nested_attributes_for :mailing_address

  TITLES = ['Mr', 'Ms', 'Dr', 'Rabbi', 'Cantor', 'Chazzan', 'Educator', 'None']

  def self.titles 
  	TITLES
  end

  def rider?
  	self.rider_reg ? true : false
  end

  def full_name
    if self.title == "None"
      self.first_name + ' ' + self.last_name
    else
      self.title + ' ' + self.first_name + ' ' + self.last_name
    end
  end



end
