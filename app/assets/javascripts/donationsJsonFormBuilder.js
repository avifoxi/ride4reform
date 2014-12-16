// incrementally query data from donation_queries to assemble full form, then submit

function DonationsFormBuilder (els) {
	this.$form = els['form'];
	this.queryPath = els['query_path'];
	this.submitPath = els['submission_path'];
	this.donationData = {};
	this.complete = false;
	this.$showProcess = $('.show_donation_in_process ul');
	
	var _this = this;

	this.$form.submit(function(e){
		e.preventDefault(e);
		console.log(e);
		_this.queryNBuild();
		
	});

}

DonationsFormBuilder.prototype = {
	queryNBuild : function(){
		var _this = this;
		this.donationData.email = $('#email').val();

		this.donationData.amount = $('#amount').val();
		// 
		// console.log(_this.donationData);
		this.queryEmailMailingAddy(_this.donationData.email);
	},
	queryEmailMailingAddy : function(email){
		var _this = this;

		$.ajax({
			type: "POST",
		  url: _this.queryPath,
		  data: {
		  	email: email
		  }
		}).done(function(response) {
		  if (response.donor){
		  	// update screen with info
		  	_this.updateShowProcess();
		  	// give option to use existing mailing_addy
		  	_this.referenceOldOrNewAddy(response.mailing_address);
		  } else {
		  	// solicit User info for 
		  }
		});	
	},
	updateShowProcess : function(){
		var _this = this;
		var data = _this.donationData;
		var donationFields = Object.getOwnPropertyNames(_this.donationData);
		for (var i=0; i < donationFields.length; i++ ){
			var li = document.createElement('li');
			li.innerHTML = donationFields[i] + ': ' +
				data[donationFields[i]];
			this.$showProcess.append(li);
		}
	},
	referenceOldOrNewAddy : function(addy){
		$('.addyInsert').text(addy) ;
		
	}
}


// prototype = {
	
// }

