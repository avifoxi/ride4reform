Notes:
 
LIVE BY END OF NOVEMBER


USER STORY 1 -- RIDER REGISTERS

- birthdate, input drop down menu 
		-- CHECK -- input in views
		-- CHECK - parse in controller to birthdate params, read to DB successfully 

- create container for form elements -- 80% of page, and fields are scaled appropriately
	-- CHECK - 	quick solution of creating form_container in css, specific fields may need addressing for correct size, but will do for now

-- User creation first is right on

BUT -- as rider fills out rider_reg complete in THIS order:

	-- CHECK - step 1 in correct order 
-- TODO - add validations

SINGLE PAGE
1) ride option
2) address contents // 2nd line optional
3) city / state / zip
4) primary phone
5) secondary phone
6) DoB
7) uploading picture
8) Bio

conditions page
	what we need from the pdf's are just conditions of entry section with checkboxes.
	3 different forms based on track choice.
	http://www.riding4reform.org/Eng/2015/Pages/Costs.asp

-- CHECK - created helper for these 

rider fee page -- here give an option with autofilled address, if we need a different address they fill, other wise use same pre-entered address from before

on RIDER page -- edit button should not be green -- maybe a better color to distinguish

stay away from green + red ... 

------------------

USER STORY 2: 
RIDER CONTINUES REGISTERATION

- user after log in should be taken to their profile page

- on edit -- give option to replace photo, and show existing photo 

- on profile page --- 
create a table with status of each registration piece. If complete, we see a check mark. If not, it's clear rider needs to complete it. 
All of these are links to either complete or update.

Place this below the donations section. 

above 'edit your profile'

make it clear to each rider -- there is a public facing part to your page

and all private info is visible only to you

do we want a preview button for public facing view? 

----------

USER STORY 3 --- UNREGISTERED DONOR WANTS TO DONATE TO A RIDER

- riders on landing page must be searchable.

- when user clicks to donate - the donation amount should be first field. It should look pretty --- 
as user enters numbers, it dynamically fills the gauge to the amount it will be post payment processing... 

-- User must be able to see paypal errors, and edit

-- BUG BUG -- donors list of rider page, listing 3 times. why?

-- MISSING -- donor must be able to enter a message to the rider.
ALSO - donor must be able to choose if amount is publically viewable, or if donation amout is secret.
ALSO - we should allow donor to be anonymous to the public-- no name, etc, no listing. their ARE calculated in total, but not listed either by name or alias.

-- MISSING -- rider gets an email from server alerting them who donated, and current % raised. 

---------

USER STORY 4 
UNREGISTERED DONOR DONATES TO ORGANIZATION -- NOT A SPECIFIC RIDER

-- riders index should NOT be home page-- 

-- home page should a simple welcome with:
	- mission statement
	- donate to our organization 
	- donate to one our riders

organization donations page
	- donate to org, with text input for where to direct this donation 

-------

USER STORY 5
DONOR RECEIVES TAX RECEIPT THANK YOU LETTER VIA EMAIL

dad gives text

------

checks

what about users / donors who don't want to use paypal ?

user navigates to donation page, chooses donate - but has option to send check

a check must be updated by admin upon receipt

donor then receives a reminder email every 2 weeks as reminder to send in check--
to change the status of your payment, please contact IMPJ at .....

-----

DATA

admin can print this data at any time, no need to persist it -- always gen new info
deliverable as CSV

list of riders
list of donors with : name, amount, address, email, rider donating to
donations by date range... admin enters date range and recieves csv of donors as above

exception report, not necessarily a csv
list of incomplete rider_regs with what is missing


-----

ADMIN --

basic content management system allows:
- swap out any pdf forms for another
- registration fee + min amount to raise should be variables
- early registration fee if applicable

- be able to nominate other admins

- must be able to start a new rider year 
	WTF is a new ride year!? how does this work 



-----

ride back through progress gauge!



