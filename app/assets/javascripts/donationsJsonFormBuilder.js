// incrementally query data from donation_queries to assemble full form, then submit

function DonationsFormBuilder (els) {
	this.$form = els['form'];
	this.queryPath = els['query_path'];
	this.donationData = {};
	this.complete = false;
	this.currentStep = 0;
	this.donorDBinfo = null;
	this.$showProcess = $('.show_donation_in_process ul');
	
	var _this = this;

	this.$form.submit(function(e){
		if (!_this.complete){
			e.preventDefault(e);
		}
		_this.stepThrough(e);	
	});

	this.steps = {
		0 : 'prepEmailAmount',
		1 : 'getEmailAmount',
		2 : 'prepPrivacyAndMessage',
		3 : 'getPrivacyAndMessage',
		4 : 'prepCC',
		5 : 'getCC',
		6 : 'prepAddress',
		7 : 'getAddress'
	}

	this.stepThrough();
}

DonationsFormBuilder.prototype = {
	stepThrough : function(event){
		var step = this.currentStep;
		var stepFunc = this.steps[step];
		this[stepFunc](event);
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
		this.currentStep += 	1;

	}, 
	getAddress : function(){
		var _this = this;
		var refDB = $('#mailing_yay_or_nay').val();
		if (refDB === 'true'){
			_this.donationData.refDB = true;
		} else {
			_this.donationData.mailing_address = {};
			_this.donationData.mailing_address.line1 = $('#donation_receipt_attributes_mailing_address_attributes_line1').val();
			_this.donationData.mailing_address.line2 = $('#donation_receipt_attributes_mailing_address_attributes_line2').val();
			_this.donationData.mailing_address.city = 	$('#donation_receipt_attributes_mailing_address_attributes_city').val();		
			_this.donationData.mailing_address.state = $('#donation_receipt_attributes_mailing_address_attributes_state').val();
			_this.donationData.mailing_address.zip = $('#donation_receipt_attributes_mailing_address_attributes_zip').val();
		}
		
		this.complete = true;
		this.stepThrough();
	},
	prepCC : function(){
		$('.donationSteps').hide();
		$('#ccForm').show();
		$('input[type=submit]').val('Submit');
		this.currentStep += 1;
	},
	getCC : function(event) {
		// validate ins
		console.log(event);
		var _this = this;
		this.donationData.cc_info = {
			'type' : $('#type').val(),
			'number' : $('#credit_card').val(),
			'expire_month' :$('#expire_month').val(),
			'expire_year' : $('#expire_year').val(),
			'cvv2' :$('#cvv2').val(),
			'first_name' : $('#first_name').val(),
			'last_name' :$('#last_name').val()
		};
		this.currentStep += 	1;
		this.stepThrough();
	},
	prepEmailAmount : function(){
		$('.donationSteps').hide();
		$('.emailAmount').show();
		this.currentStep += 1;
	},
	getEmailAmount : function(){
		console.log('firing');
		var _this = this;

		// TODO add validations...
		var em = $('#donation_receipt_attributes_amount').val();
		var am = $('#donation_receipt_attributes_user_attributes_email').val();
		if ( em !== '' && am !== ''){
			_this.donationData.email = em;
			_this.donationData.amount = am;
			_this.currentStep += 1;
			_this.queryEmailInDBGetAddy(_this.donationData.email);	
			_this.stepThrough();
		}

	},
	getPrivacyAndMessage : function() {
		var anon = $('#donation_anonymous').val();
		var message = $('#donation_message_to_rider').val();
		this.donationData.anonymous = anon;
		this.donationData.message = message;
		this.currentStep += 1;
		this.stepThrough();

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
			var content;
			if (typeof data[donationFields[i]] === 'object'){
				content = '<i class="fa fa-check-square-o"></i>';
			} else {
				content = data[donationFields[i]];
			}
			li.innerHTML = '<strong>' + donationFields[i] + ':</strong> ' +
				content;
			this.$showProcess.append(li);
		}
	},
	dbAddyOptionShow : function(addy){
		// $('#emailAmount').hide();
		$('.addyInsert').text(addy);
	}
}




