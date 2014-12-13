BUGS -- 

FIREFOX
the rider reg control panel does not work correctly


//// 

CSV functionality must move into Admin Path only

///

DEC 13
FIREFOX
Password confirmation- I purposely typed in a false match. The system rejects and clears both password and retype password field without any error message. Should have a message
 --- for this I have no idea why the code that works in other browsers doesn't work in firefox... I could create a work around, but this we're using an industry standard registration system. it's odd that this isn't anticipated.
 Your call - is this safeguard worth it for you?


Entering Zip code- tried entering 5+4 zip code. Error message said please enter proper zip- to correct this I suggest that the fields be trimmed to only allow the maximum field length allowed (zip=5) year=4, CC#=16 etc.

	-- done

Paying- I entered too many digits in the credit card-rejected but error code was please enter credit card again if limit to 16 digits problem solved
Card expiration allowed a past date (January 2014) – are you simply going to pass any valid length CC info to PayPal to edit?

	-- writing additional validation - DONE
