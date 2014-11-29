Tested Admin and it seems to work. Here are the shortfalls: When setting up a new admin from an existing user I am not sure what the protocol is. I clicked on a user and then what? The system shows him as an admin but he has no logon or password- you should not allow him to have the same logon and password as a user as the default. That is a major security no-no.
Also there should be a function to show all admins and their logons
 
Bugs/Issues:
<!-- 1.       The Sign Up button does not do anything- I assume it is the same function as Register Now? --- DONE
 -->
<!-- 2.       Rider Reg- Sequence of Birthdate should be Month, Day and then Year. -- DONE
 -->

Also boxes should be same size as input

<!-- 3.       I did not click the agree button and you took me to the next screen to pay!

	DONE
 -->
4.       Payment you prefill the Separate Billing Address with the default address- should be blank- when hit enter got a sorry something went wrong message

{"utf8"=>"✓", "authenticity_token"=>"wq/uMAH/vS/jznrZdGRFEeYq7AXZ9hHMICEhgjURHdE=", "rider_reg"=>
	{

	"rider_attributes"=>
		{
			"receipt"=>{"type"=>"visa", "credit_card"=>"", "month"=>"1", "expire_year"=>"2014", "cvv2"=>"", "first_name"=>"", "last_name"=>""}, 
		
			"id"=>"14"}, 
			"mailing_address"=>
				{
					"line1"=>"addy1", "line2"=>"addy2", "city"=>"city", "state"=>"Alaska", "zip"=>"12124"
				}
		}, 
	
	"reference_user_address"=>"nil", "commit"=>"Register"
}



Top things to get working now:
1.       Fix bugs/issues

2.       Ability for admin to process paper checks as donations

3.       Reports

Making progress. I think you are on the right track. I suggest that you send me a page to test as soon as you think it is working [properly- I will test for bugs and comments on aesthetic appearance as well. Once we have that all working then the next step is testing the paypal interface and the last step is integrating to IMPJR R4R site.