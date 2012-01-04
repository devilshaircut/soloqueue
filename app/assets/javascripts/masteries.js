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

	// Add a point to a mastery via left click.
	$(".mastery").click(function() {
		console.log($(this).find(".value .current").text());		
		if (parseInt($(this).find(".value .current").text()) < parseInt($(this).find(".value .maximum").text()) && parseInt($("#remaining").text()) > 0) {
			$(this).find(".value .current").html(parseInt($(this).find(".value .current").text()) + 1);
			$("#remaining").html(parseInt($("#remaining").text()) - 1);
			treeSum();
		};
	});
	
	// Remove a point from a mastery via right click.
	$(".mastery").rightClick(function() {
		console.log($(this).find(".value .current").text());		
		if (parseInt($(this).find(".value .current").text()) <= parseInt($(this).find(".value .maximum").text()) && parseInt($(this).find(".value .current").text()) > 0 && parseInt($("#remaining").text()) < 30) {
			$(this).find(".value .current").html(parseInt($(this).find(".value .current").text()) - 1);
			$("#remaining").html(parseInt($("#remaining").text()) + 1);
			treeSum();
		};
	});

	function treeSum() {
		var offensiveSum = 0;
		var defensiveSum = 0;
		var utilitySum = 0;
		$("#masteries-offensive .current").each(function() {
			offensiveSum += parseInt($(this).text());
		});
		$("#masteries-defensive .current").each(function() {
			defensiveSum += parseInt($(this).text());
		});
		$("#masteries-utility .current").each(function() {
			utilitySum += parseInt($(this).text());
		});
		$("#offense-points .spent").html(offensiveSum);
		$("#defense-points .spent").html(defensiveSum);
		$("#utility-points .spent").html(utilitySum);
	};

});










