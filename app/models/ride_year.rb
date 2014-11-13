class RideYear < ActiveRecord::Base
  has_many :rider_regs

  def self.current
  	max = RideYear.maximum(:current)
  	RideYear.find_by(current: max)
  end

  def set_as_current
  	max = RideYear.maximum(:current)
  	self.update_attributes(current: max + 1)
  end

end
