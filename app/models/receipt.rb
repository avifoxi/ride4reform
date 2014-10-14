class Receipt < ActiveRecord::Base
	belongs_to :user
	has_one :address, :as => :addressable



end
