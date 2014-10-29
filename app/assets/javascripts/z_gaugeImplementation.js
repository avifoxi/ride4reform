function buildGauge(raised) {
	var g = new JustGage({
    id: "gauge",
    value: raised,
    min: 0,
    max: 100,
    title: "Percent of Goal"
  });
}

var ready;
ready = function() {

  var perc = $('#percent_of_goal').html();
	if ( $('#gauge').length > 0 ) {
		buildGauge(perc)
	}

};

$(document).ready(ready);
$(document).on('page:load', ready);