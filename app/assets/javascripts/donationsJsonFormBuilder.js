// incrementally query data from donation_queries to assemble full form, then submit

function DonationsFormBuilder (els) {
	this.$form = els['form'];
	this.queryPath = els['query_path'];
	this.submitPath = els['submission_path'];
	this.donationData = {};
	// this.complete = false;
	this.currentStep = 0;
	this.donorDBinfo = null;
	this.$showProcess = $('.show_donation_in_process ul');
	
	var _this = this;

	this.$form.submit(function(e){
		e.preventDefault(e);
		_this.stepThrough();	
	});

	this.steps = {
		0 : 'prepEmailAmount',
		1 : 'getEmailAmount',
		2 : 'prepPrivacyAndMessage',
		3 : 'getPrivacyAndMessage',
		4 : 'prepAddress',
		5 : 'getAddress'
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
		this.updateShowProcess();
	},
	prepAddress : function(){
		var _this = this;
		$('.donationSteps').hide();
		var found = this.donorDBinfo;
		if (found){
			_this.dbAddyOptionShow(found.mailing_address);
		}
		$('.newAddy').show();
		this.currentStep += 1;

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
			_this.stepThrough();
		}

	},
	getPrivacyAndMessage : function() {
		var anon = $('#privacy').val();
		var message = $('#message').val();
		this.donationData.anon = anon;
		this.donationData.message = message;
		this.currentStep += 1;
	},
	prepPrivacyAndMessage : function() {
		// console.log('in prep priv + mess');
		$('.donationSteps').hide();
		$('#privacyAndMessage').show();
		this.currentStep += 1;
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
		  // console.log(response);
		  if (response.donor){
		  	// save json for reference
		  	_this.donorDBinfon = response;

		  	// give option to use existing mailing_addy
		  	// _this.dbAddyOptionShow(response.mailing_address);
		  } 
		});	
	},
	updateShowProcess : function(){
		var _this = this;
		var data = _this.donationData;
		var donationFields = Object.getOwnPropertyNames(_this.donationData);
		// first clear before appending... 
		this.$showProcess.children().remove();

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

