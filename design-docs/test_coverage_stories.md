EXISTING FUNCTIONALITY

Creating Rider Registration

User clicks to new registration, to create their RiderReg

New user enters first_name, last_name, email, pword.
User created in DB.

Taken to RR new
entering valid info on this page and submitting creates:
- RiderReg associated to User
- MailingAddress associated to User

Taken to Terms page.
Must agree.
If user agrees, updates 'accept_terms' boolean for RiderReg.

Taken to Registration Fee page.
If all is correct, and user submits:
- PayPal call made correctly (note to add API keys in command line, keep out of public repo)
- Receipt is associated with RiderReg 
- RiderReg 'paid' boolean updated
- User may choose to reference the reciept with their existing MailingAddress, or create a new MailingAddress associated with the Receipt

User then taken to their RiderReg profile page (show). They can update fields, and see what fields are complete or incomplete in the RiderReg status panel. 

ALSO -- test invalid entries should be rejected
may need to add AR Model validations


TODO --

unregistered User may navigate to an existing RiderReg show page, choose to Donate.

Donor walked through donation process --
1) Confirm the RiderReg profile you want to Donate to, and Amount, and at minimum an associated email account.
2) Check DB -- does a donor_user with this email addy exist? 
If NOT in DB --
	enter new mailing addy, and necessary fields for PayPal process
If User IS in DB 
	use existing MailingAddress ?
		if yes, associate
		if no, create MailingAddy + associate to Receipt

Process payment, with Success and Fail routes

IF the above process works, then the below should automatically upadate.
	After process -- The RiderReg that received the Donation should see the donor info on their profile page, with amount of $$ donated. 
	The gauge + percentage should be updated to reflect % of goal raised.


