class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def donation_receipt(donation)
    p @donor = donation.user.full_name
    p @amount = donation.receipt.amount
    p @email = donation.user.email
    p @rider = donation.rider.full_name

    mail(to: @email, subject: "Ride4Reform Donation Receipt")
  end
end
