$( document ).ready(function() {

	$('#percent_of_goal').html()
  
});


function buildGauge(raised) {
	var g = new JustGage({
    id: "gauge",
    value: 12,
    min: 0,
    max: 100,
    title: "Visitors"
  });
}