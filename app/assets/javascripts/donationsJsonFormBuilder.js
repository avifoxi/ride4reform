// incrementally query data from donation_queries to assemble full form, then submit

function DonationsFormBuilder (els) {
	this.$form = els['form'];
	this.queryPath = els['query_path'];
	this.submitPath = els['submission_path'];
	this.donationData = {};

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
		  console.log(response);
		});	

	}
}


// prototype = {
	
// }

