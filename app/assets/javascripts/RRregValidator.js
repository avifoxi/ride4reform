function RRvalidation(subButton, minGoal) {
	this.$subButton = subButton;
	this.minGoal = minGoal;

	var _this = this;
	this.$subButton.click( function(ev){
		_this.validate(ev);
	});
}

RRvalidation.prototype = {
	validate : function(ev) {
		var _this = this;
		var vds = [
			_this.checkMailPhone(),
			_this.checkZip(),
			_this.checkGoal()
		]
		for (var i=0; i < vds.length; i++){
			if (vds[i] !== 'valid'){
				_this.throwAlert(ev, vds[i]);
				return;
			}
		}
	},
	throwAlert : function(evt, text){
		evt.preventDefault();
		alert(text);
	},
	checkZip : function(){
		var input = $('#rider_reg_rider_attributes_mailing_address_attributes_zip').val();		
		var testing = Number(input);
		var failText = 'Please enter a valid postal code';

		if ( !testing.valueOf() ){
			return failText;
		}  
		if (input.length !== ( 5 || 9 ) ) {
			return failText;
		}
		return 'valid';
	},
	checkMailPhone : function() {
		var mp = [ $('#rider_reg_rider_attributes_mailing_address_attributes_line1'),
		$('#rider_reg_rider_attributes_mailing_address_attributes_city'),
		$('#rider_reg_primary_phone')];
		var failText = 'Please enter complete contact information';
		var clear = true;
		mp.forEach( function($el){

			if ( $el.val() === '') {
				clear = false; 
			}
		});
		
		return (!clear) ? failText : 'valid';
	},
	checkGoal : function() {
		var inputGoal = Number($('#rider_reg_goal').val());
		var min = this.minGoal;
		var failText = 'Please enter a fundraising goal in above $' + 
			min;
		return inputGoal < min ? failText : 'valid' ;
	}
}