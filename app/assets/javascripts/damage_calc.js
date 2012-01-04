var damageCalc = {

	// a = damageValue
	// b = damageStat
	// c = damageScaling
	// d = resist
	// e = resistReduxFlat
	// f = resistReduxPercent
	// g = resistPenFlat
	// h = resistPenPercent	
	calculateDamage: function (a, b, c, d, e, f, g, h ) {
		
		var baseDamage = a + (b * c);
		var resist = ((((d * ((100 - e) / 100)) - f) - g) * ((100 - h) / 100));

		if (resist >= 0) {
			resist = 100 / (100 + resist);
		}
		else {
			resist = 2 - (100 / (100 - resist));
		}

		var damage = baseDamage * resist;

		return damage;
		
	}

};



$(document).ready(function () {

	$("input[type='submit']").click(function() {
		console.log("test");
		var damageValue = parseFloat($("#damageValue").val());
		var damageStat = parseFloat($("#damageStat").val());
		var damageScaling = parseFloat($("#damageScaling").val());
		var resist = parseFloat($("#resist").val());
		var resistReduxFlat = parseFloat($("#resistReduxFlat").val());
		var resistReduxPercent = parseFloat($("#resistReduxPercent").val());
		var resistPenFlat = parseFloat($("#resistPenFlat").val());
		var resistPenPercent = parseFloat($("#resistPenPercent").val());
		console.log([damageValue, damageStat, damageScaling, resist, resistReduxPercent, resistReduxFlat, resistPenFlat, resistPenPercent]);
		console.log(damageCalc.calculateDamage(damageValue, damageStat, damageScaling, resist, resistReduxPercent, resistReduxFlat, resistPenFlat, resistPenPercent));
		if (isNaN(damageCalc.calculateDamage(damageValue, damageStat, damageScaling, resist, resistReduxPercent, resistReduxFlat, resistPenFlat, resistPenPercent))) {
			$('#damageResult').replaceWith("<div id='damageResult'>Please input only numerals.</div>");
		}
		else {
			$('#damageResult').replaceWith("<div id='damageResult'>" + damageCalc.calculateDamage(damageValue, damageStat, damageScaling, resist, resistReduxPercent, resistReduxFlat, resistPenFlat, resistPenPercent) + "</div>");
		}
	});

});










