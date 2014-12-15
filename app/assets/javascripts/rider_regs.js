// $(document).ready(function(){

// 	var rrpView = new RiderStatusPanelView({
// 		'toggleLink' : $('.showStatPan') ,
// 		'table' : $('.reg_status_panel') ,
// 		'form' : $('.edit_rider_reg'),
// 		'cancel' : $('.cancel')
// 	});

// });

function RiderStatusPanelView(els) {
	this.$toggleLink = els['toggleLink'];
	this.$table = els['table'];
	this.$form = els['form'];
	this.$cancel = els['cancel']

	// table + form hidden in css - form_styles
	this.tableShowing = false;

	var that = this;

	this.$toggleLink.click(function(e){
		e.preventDefault();
		if (that.tableShowing){
			that.$table.hide();
		} else {
			that.$table.show();
		}
		that.tableShowing = !(that.tableShowing);
	});

	this.$table.click(function(e) {
		e.preventDefault();
		that.parseForUpdate(e.target.innerText);
	});

	this.$cancel.click(function(e){
		e.preventDefault();
		$(that.$form).hide();
		$('.update').hide();
	})
}

RiderStatusPanelView.prototype = {

	parseForUpdate : function(clickText) {
		var field;
		var that = this;
		switch (clickText) {
		  case "Ride Option":
		    that.revealField('ride');
		    break;
		  case "Mailing Address":
		    that.revealField('mail');
		    break;
		  case "Phones":
		    that.revealField('phones');
		    break;
		  case "Birthdate":
		    that.revealField('bday');
		    break;
		  case "Photo":
		    that.revealField('photo');
		    break;
		  case "Bio":
		    that.revealField('bio');
		    break;
		  case "Fundraising Goal":
		    that.revealField('goal');
		    break;
		  default:
		    console.log("invalid");
		}
	},
	revealField : function(field) {
		this.$form.show();
		$('.' + field + ', .submit, .cancel' ).show();
	}
}
