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
		//console.log($(this).find(".value .current").text());
		// console.log(prerequisite($(this)));
		// console.log( "#" + $(this).parent().parent().attr("id") );
		if (prerequisiteUp($(this)) == true && parseInt($(this).find(".value .current").text()) < parseInt($(this).find(".value .maximum").text()) && parseInt($("#remaining").text()) > 0) {
			$(this).find(".value .current").html(parseInt($(this).find(".value .current").text()) + 1);
			$("#remaining").html(parseInt($("#remaining").text()) - 1);
			treeSum();
		};
	});
	
	// Remove a point from a mastery via right click.
	$(".mastery").rightClick(function() {
		console.log($(this).find(".value .current").text());
		if (prerequisiteDown($(this)) == true && parseInt($(this).find(".value .current").text()) <= parseInt($(this).find(".value .maximum").text()) && parseInt($(this).find(".value .current").text()) > 0 && parseInt($("#remaining").text()) < 30) {
			$(this).find(".value .current").html(parseInt($(this).find(".value .current").text()) - 1);
			$("#remaining").html(parseInt($("#remaining").text()) + 1);
			treeSum();
		};
	});
	
	function prerequisiteUp(element) {
		var row1 = 0;
		var row2 = 0;
		var row3 = 0;
		var row4 = 0;
		var row5 = 0;
		$("#" + element.parent().parent().attr("id") + " .masteries-1 .mastery").each(function() { row1 += parseInt($(this).text()); });
		$("#" + element.parent().parent().attr("id") + " .masteries-2 .mastery").each(function() { row2 += parseInt($(this).text()); });
		$("#" + element.parent().parent().attr("id") + " .masteries-3 .mastery").each(function() { row3 += parseInt($(this).text()); });
		$("#" + element.parent().parent().attr("id") + " .masteries-4 .mastery").each(function() { row4 += parseInt($(this).text()); });
		$("#" + element.parent().parent().attr("id") + " .masteries-5 .mastery").each(function() { row5 += parseInt($(this).text()); });
		if (element.parent().attr("class") == "masteries-1") { return true; };
		if (element.parent().attr("class") == "masteries-2") {			
			if (row1 >= 4) { return true; }
			else { return false; };
		};
		if (element.parent().attr("class") == "masteries-3") {			
			if (row1 + row2 >= 8) { return true; }
			else { return false; };
		};
		if (element.parent().attr("class") == "masteries-4") {			
			if (row1 + row2 + row3 >= 12) { return true; }
			else { return false; };
		};
		if (element.parent().attr("class") == "masteries-5") {			
			if (row1 + row2 + row3 + row4 >= 16) { return true; }
			else { return false; };
		};
		if (element.parent().attr("class") == "masteries-6") {			
			if (row1 + row2 + row3 + row4 + row5 >= 20) { return true; }
			else { return false; };
		};
	};
	
	function prerequisiteDown(element) {
		var row1 = 0;
		var row2 = 0;
		var row3 = 0;
		var row4 = 0;
		var row5 = 0;
		var row6 = 0;
		$("#" + element.parent().parent().attr("id") + " .masteries-1 .mastery").each(function() { row1 += parseInt($(this).text()); });
		$("#" + element.parent().parent().attr("id") + " .masteries-2 .mastery").each(function() { row2 += parseInt($(this).text()); });
		$("#" + element.parent().parent().attr("id") + " .masteries-3 .mastery").each(function() { row3 += parseInt($(this).text()); });
		$("#" + element.parent().parent().attr("id") + " .masteries-4 .mastery").each(function() { row4 += parseInt($(this).text()); });
		$("#" + element.parent().parent().attr("id") + " .masteries-5 .mastery").each(function() { row5 += parseInt($(this).text()); });
		$("#" + element.parent().parent().attr("id") + " .masteries-6 .mastery").each(function() { row6 += parseInt($(this).text()); });
		if (element.parent().attr("class") == "masteries-1") {			
			if (row2 + row3 + row4 + row5 + row6 == 0 || row1 > 4) { return true; }
			else { return false; };
		};
		if (element.parent().attr("class") == "masteries-2") {			
			if (row3 + row4 + row5 + row6 == 0 || row1 + row2 > 8) { return true; }
			else { return false; };
		};
		if (element.parent().attr("class") == "masteries-3") {			
			if (row4 + row5 + row6 == 0 || row1 + row2 + row3 > 12) { return true; }
			else { return false; };
		};
		if (element.parent().attr("class") == "masteries-4") {			
			if (row5 + row6 == 0 || row1 + row2 + row3 + row4 > 16) { return true; }
			else { return false; };
		};
		if (element.parent().attr("class") == "masteries-5") {			
			if (row6 == 0 || row1 + row2 + row3 + row4 + row5 > 20) { return true; }
			else { return false; };
		};
		if (element.parent().attr("class") == "masteries-6") { return true; };
	};

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










