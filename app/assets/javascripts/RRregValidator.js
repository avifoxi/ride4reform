// global function, in case e.preventDefault() fails ... ala firefox

function ie8SafePreventEvent(e){
		alert('stopping');
    if(e.preventDefault){ e.preventDefault()}
    else{e.stop()};

    e.returnValue = false;
    e.stopPropagation();        
}

// and below, a validator object

function RRvalidation(subButton, minGoal) {
	this.$subButton = subButton;
	this.minGoal = minGoal;
	
	var _this = this;

	this.repertoires = {
		'Please fill out your Rider Registration!' : [
			'checkMailPhone',
			'checkZip',
			'checkGoal'
		],
		'Registration Fee' : [
			'checkCCnum',
			'checkCVV',
			'checkCCnames',
			'ensureAddyRef'
		]
	}

	this.$subButton.click( function(ev){

		ev.preventDefault(ev);
		_this.validate(ev);
	});


}

RRvalidation.prototype = {
	validate : function(ev) {

		var _this = this;
		// console.log(_this);
		var rep = this.repertoires[ _this.selectRep()];
		// var clear = true;

		// ev.preventDefault();
		for (var i=0; i < rep.length; i++){
			var vdText = _this[rep[i]]();
			if (vdText !== 'valid'){
				_this.throwAlert(ev, vdText);
				return;
			}
		}
		$('form').submit();
	},
	selectRep : function(){
	
		return $('.form_container h3')[0].innerHTML;
	},
	throwAlert : function(evt, text){
		evt.originalEvent.preventDefault(evt);
		alert(text);
	},
	ie8SafePreventEvent : function(e){
		alert('stopping');
    if(e.preventDefault){ e.preventDefault()}
    else{e.stop()};

    e.returnValue = false;
    e.stopPropagation();        
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
		var mp = [ 
			$('#rider_reg_rider_attributes_mailing_address_attributes_line1'),
			$('#rider_reg_rider_attributes_mailing_address_attributes_city'),
			$('#rider_reg_primary_phone')
		];
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
	},
	checkCCnum : function(){
		var ccNum = $('#rider_reg_rider_attributes_receipt_credit_card').val();

		var numCheck = Number (ccNum);
		var failText = 'Please enter your full credit card information';

		if ( !numCheck.valueOf() ){
			return failText;
		}  
		if (ccNum.length !== 16) {
			return failText;
		}
		return 'valid';
	},
	checkCVV : function(){
		var cvv = $('#rider_reg_rider_attributes_receipt_cvv2').val();
		var numCheck = Number (cvv);
		var failText = 'Please enter a valid cvv number';

		if ( !numCheck.valueOf() ){
			return failText;
		}  
		if ( (cvv.length > 4 )||(cvv.length < 3) ) {
			return failText;
		}
		return 'valid';
	},
	checkCCnames : function(){
		var failText = 'Please enter your first and last name as it appears on your credit card.';
		var clear = true;

		var names = [
			$('#rider_reg_rider_attributes_receipt_first_name'),
			$('#rider_reg_rider_attributes_receipt_last_name')
		] 

		names.forEach( function($el){
			if ( $el.val() === '') {
				clear = false; 
			}
		});
		return (!clear) ? failText : 'valid';
	},
	ensureAddyRef : function() {
		var _this = this;
		console.log(_this);
		var ref = $('#refUser').val();
		var failText = '';
		if ( ref === 'nil'){
			failText = 'Please choose whether to reference your existing address.';
		} 
		var wtf = _this.checkCCnames();
		console.log(wtf);
		var falseCheck = _this.cda();
		console.log(falseCheck)
		if (ref === 'false'){
			// console.log(falseCheck);
			failText = falseCheck;
		}
		// console.log(failText);
		return failText === '' ? 'valid' : failText;
	},
	cda : function(){
		var clear = true;
		var failText = 'Please complete your separate billing address.';
		var els = [
			$('#rider_reg_mailing_address_line1'),
			$('#rider_reg_mailing_address_city'),
			$('#rider_reg_mailing_address_zip')
		]
		els.forEach( function($el){
			if ( $el.val() === '') {
				clear = false; 
			}
		});
		return (!clear) ? failText : '';
	}
}