class RiderReg < ActiveRecord::Base
  belongs_to :ride_year
	
	belongs_to :rider, :class_name => "User"
	delegate :first_name, :last_name, :title, :full_name, :receipts, :mailing_address, to: :rider, allow_nil: true, prefix: false

  has_many :donations_received, :foreign_key => "rider_reg_id", :class_name => "Donation"

  accepts_nested_attributes_for :rider

  before_validation :associate_current_year

  # This method associates the attribute ":photo" with a file attachment, paperclip gem
  has_attached_file :photo, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  # validates :rider, uniqueness: { scope: :ride_year_id,
  #   message: "rider may only register once per ride_year" }
  validates_uniqueness_of :rider, scope: :ride_year_id, message: "rider may only register once per ride_year" 

  validates :goal, numericality: { greater_than_or_equal_to:  :selfs_current_min }
  # RideYear.current.min_goal
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

  def self.as_csv
    CSV.generate do |csv|
      columns = ["id", "ride_year", "ride_option", "paid",
                 "accept_terms", "goal", "raised", "rider",
                 "birthday", "email", "phone1", "phone2",
                 "address1", "address2", "city", "state",
                 "zip", "bio", "date"]
      csv << columns

      all.each do |item|
        row = [item.id,
               item.ride_year,
               item.ride_option,
               item.paid,
               item.accept_terms,
               item.goal,
               item.raised,
               item.rider.full_name,
               item.birthdate,
               item.rider.email,
               item.primary_phone,
               item.secondary_phone,
               item.mailing_address.line1,
               item.mailing_address.line2,
               item.mailing_address.city,
               item.mailing_address.state,
               item.mailing_address.zip,
               item.bio,
               item.created_at]
        csv << row
      end
    end
  end

  private
    def associate_current_year
      self.ride_year = RideYear.current
    end

    def selfs_current_min
      self.ride_year.min_goal
    end
  
end
