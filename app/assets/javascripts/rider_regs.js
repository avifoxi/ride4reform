$(document).ready(function(){

	var rrpv = new RiderStatusPanelView({
		'toggleLink' : $('.showStatPan') , 
		'table' : $('.reg_status_panel') ,
		'form' : $('.edit_rider_reg')
	});

});

function RiderStatusPanelView(els) {
	this.$toggleLink = els['toggleLink'];
	this.$table = els['table'];
	this.$form = els['form'];

	this.tableShowing = false;
	this.formShowing = false;

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
		    console.log("Apples are $0.32 a pound.");
		    break;
		  case "Phones":
		    console.log("Bananas are $0.48 a pound.");
		    break;
		  case "Birthdate":
		    console.log("Cherries are $3.00 a pound.");
		    break;
		  case "Photo":
		    console.log("Photo.");
		    break;
		  case "Bio":
		    console.log("Mangoes and papayas are $2.79 a pound.");
		    break;
		  case "Fundraising Goal":
		  default:
		    console.log("Sorry, we are out of " + expr + ".");
		}
	}, 
	revealField : function(field) { 
		this.$form.show();
		$('.' + field + ', .submit' ).show();
	}
}





