require 'rails_helper'

RSpec.describe User, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

#### NOTES
# Not entirely clear of the relationship btwn riders and ride years
# from what i see, a ride year has many riders. not sure how the interaction
# is supposed to work. remember to ask avi.
# ride years also don't have any relationship to admins. not sure if would like
# to do permissions on the database end. i'm down to dive into the database and
# set permissions. making a user interface for admins was mentioned. it may be
# cheaper for the customer to not build that out and for them to ask us to do it.
# it would take a total of 5 minutes to give permission to a new admin, vs building
# out an admin page.

# receipt can have one mailing address, no relationship on the other end.
# Guessing this is for normalization
