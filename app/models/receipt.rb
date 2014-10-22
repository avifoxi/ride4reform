class Receipt < ActiveRecord::Base
	belongs_to :user
	has_one :mailing_address, :as => :addressable
  
end
