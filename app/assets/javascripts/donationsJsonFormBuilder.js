// incrementally query data from donation_queries to assemble full form, then submit

function DonationsFormBuilder (els) {
	this.$form = els['form'];
	this.queryPath = els['query_path'];
	this.submitPath = els['submission_path'];
	this.donationData = {};
	// this.complete = false;
	this.currentStep = 0;
	this.donorExistsInDB = false;
	this.$showProcess = $('.show_donation_in_process ul');
	
	var _this = this;

	this.$form.submit(function(e){
		e.preventDefault(e);
		_this.stepThrough();	
	});

	this.steps = {
		0 : 'prepEmailAmount',
		1 : 'getEmailAmount',
		2 : 'prepAddress',
		3 : 'getAddress'
		// 3 : 'cc_form',
		// 3 : 'privacyAndMessage',
		// 4 : 'submit'
	}

	this.stepThrough();
}

DonationsFormBuilder.prototype = {
	// init : function(){
	// 	$('.donationSteps').hide();
		
	// },
	stepThrough : function(){
		var step = this.currentStep;
		var stepFunc = this.steps[step];
		this[stepFunc]();
	},

	prepEmailAmount : function(){
		$('.donationSteps').hide();
		$('#emailAmount').show();
		this.currentStep += 1;
	},
	getEmailAmount : function(){
		console.log('firing');
		var _this = this;

		// TODO add validations...
		var em = $('#email').val();
		var am = $('#amount').val();
		if ( em !== '' && am !== ''){
			_this.donationData.email = em;
			_this.donationData.amount = am;
			_this.currentStep += 1;
			_this.queryEmailInDBGetAddy(_this.donationData.email);	
		}

	},
	queryEmailInDBGetAddy : function(email){
		var _this = this;

		$.ajax({
			type: "POST",
		  url: _this.queryPath,
		  data: {
		  	email: email
		  }
		}).done(function(response) {
		  console.log(response);
		  if (response.donor){
		  	// update screen with info
		  	// give option to use existing mailing_addy
		  	_this.dbAddyOptionShow(response.mailing_address);
		  } else {
		  	// solicit User info for 
		  }
		  // _this.privacyAndMessage();
		});	
	},
	updateShowProcess : function(){
		var _this = this;
		var data = _this.donationData;
		var donationFields = Object.getOwnPropertyNames(_this.donationData);
		// first clear before appending... 
		for (var i=0; i < donationFields.length; i++ ){
			var li = document.createElement('li');
			li.innerHTML = donationFields[i] + ': ' +
				data[donationFields[i]];
			this.$showProcess.append(li);
		}
	},
	dbAddyOptionShow : function(addy){
		// $('#emailAmount').hide();
		$('.addyInsert').text(addy);
	}
}


// prototype = {
	
// }

