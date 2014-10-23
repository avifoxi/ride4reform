class UserMailer < ActionMailer::Base
  default from: "ride4reform@gmail.com"

  def donation_receipt(donation)
    @donor = donation.user.full_name
    @amount = donation.receipt.amount
    @email = donation.user.email
    @rider = donation.rider.full_name

    mail(to: @email, subject: "Ride4Reform Donation Receipt")
  end
end
