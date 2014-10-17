require 'rails_helper'
require_relative 'feature_helper_methods'

describe "the donation process" do
	## call helper method to sign up and register a rider. now, just call lower method
    it "user donates to registered rider" do
        register_new_rider
    end
end


