class RiderReg < ActiveRecord::Base
  belongs_to :ride_year
	
	belongs_to :rider, :class_name => "User"
	delegate :first_name, :last_name, :title, :full_name, to: :rider, allow_nil: true, prefix: false

	has_many :donations_received, through: :rider
  has_one :mailing_address, :as => :addressable

  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :photo, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/






  RIDE_OPTIONS = ['Original Track', 'Light Track', 'Hiking', 'Combination Hiking/Riding']

  def self.ride_options 
  	RIDE_OPTIONS
  end

  def percent_of_goal
    return "0" if self.goal <= 0
    
  	perc = (self.raised.to_f / self.goal.to_f).round(2) * 100
  	perc.to_i.to_s
  end

  def donors
    donor_arr = []
    self.donations_received.each do |d|
      donor_arr << d.receipt.user
    end
    donor_arr
  end
  
end
