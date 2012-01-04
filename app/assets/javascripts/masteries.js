var masteriesCalc = {

	masteries: {
		summoners_wrath: {
			name: "Summoner's Wrath",
			min: 0,
			max: 1
		},
		brute_force: {
			name: "Brute Force",
			min: 0,
			max: 3
		}
	}

};



$(document).ready(function () {

	$(".mastery").click(function() {
		console.log($(this).find(".value .current").text());		
		if (parseInt($(this).find(".value .current").text()) < parseInt($(this).find(".value .maximum").text()) && parseInt($("#remaining").text()) > 0) {
			$(this).find(".value .current").html(parseInt($(this).find(".value .current").text()) + 1);
			$("#remaining").html(parseInt($("#remaining").text()) - 1);
		};
	});
	
	$(".mastery").rightClick(function() {
		console.log($(this).find(".value .current").text());		
		if (parseInt($(this).find(".value .current").text()) <= parseInt($(this).find(".value .maximum").text()) && parseInt($(this).find(".value .current").text()) > 0 && parseInt($("#remaining").text()) < 30) {
			$(this).find(".value .current").html(parseInt($(this).find(".value .current").text()) - 1);
			$("#remaining").html(parseInt($("#remaining").text()) + 1);
		};
	});



});










