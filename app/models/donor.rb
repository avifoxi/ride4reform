class Donor < ActiveRecord::Base
	has_many :donations
  has_many :riders, through: :donations

end
