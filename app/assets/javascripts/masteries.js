$(document).ready(function () {
	
	$("#reset-points").click(function() {
		$(".mastery .current").html(0);
		$(".spent").html(0);
		$("#remaining").html(30);
		$(".mastery").each(function() {
			$(this).removeClass("mastery-active");
		});
	});
	
	$("#hash-url").focus(function(){
	  this.select();
	}).mouseup(function(){
	  this.select();
	});

	// Add a point to a mastery via left click.
	$(".mastery").click(function() {
		if (requiredSkillUp($(this)) == true && prerequisiteUp($(this)) == true && parseInt($(this).find(".value .current").text()) < parseInt($(this).find(".value .maximum").text()) && parseInt($("#remaining").text()) > 0) {
			$(this).find(".value .current").html(parseInt($(this).find(".value .current").text()) + 1);
			$("#remaining").html(parseInt($("#remaining").text()) - 1);
			treeSum();
		}
		if (parseInt($(this).find(".value .current").text()) == 1) {
			$(this).toggleClass("mastery-active");
		}
		event.preventDefault();
	});
	
	// Remove a point from a mastery via right click.
	$(".mastery").rightClick(function() {
		if (requiredSkillDown($(this)) == true && prerequisiteDown($(this)) == true && parseInt($(this).find(".value .current").text()) <= parseInt($(this).find(".value .maximum").text()) && parseInt($(this).find(".value .current").text()) > 0 && parseInt($("#remaining").text()) < 30) {
			$(this).find(".value .current").html(parseInt($(this).find(".value .current").text()) - 1);
			$("#remaining").html(parseInt($("#remaining").text()) + 1);
			treeSum();
		}
		if (parseInt($(this).find(".value .current").text()) == 0) {
			$(this).removeClass("mastery-active");
		}
		event.preventDefault();
	});
	
	processHash();

  $(".mastery").click(updateHash).rightClick(updateHash);

});

// Checks skill-specific requirements to add a point.
function requiredSkillUp(element) {
	if (element.attr("id") == "lethality" && parseInt($("#deadliness .current").text()) != parseInt($("#deadliness .maximum").text())) { return false; }
	else if (element.attr("id") == "weapon-expertise" && parseInt($("#alacrity .current").text()) != parseInt($("#alacrity .maximum").text())) { return false; }
	else if (element.attr("id") == "arcane-knowledge" && parseInt($("#sorcery .current").text()) != parseInt($("#sorcery .maximum").text())) { return false; }
	else if (element.attr("id") == "veterans-scars" && parseInt($("#durability .current").text()) != parseInt($("#durability .maximum").text())) { return false; }
	else if (element.attr("id") == "bladed-armor" && parseInt($("#tough-skin .current").text()) != parseInt($("#tough-skin .maximum").text())) { return false; }
	else if (element.attr("id") == "meditation" && parseInt($("#expanded-mind .current").text()) != parseInt($("#expanded-mind .maximum").text())) { return false; }
	else if (element.attr("id") == "wealth" && parseInt($("#greed .current").text()) != parseInt($("#greed .maximum").text())) { return false; }
	else { return true; }
};

// Checks skill-specific requirements to remove a point.
function requiredSkillDown(element) {
	if (element.attr("id") == "deadliness" && parseInt($("#lethality .current").text()) >= 1) { return false; }
	else if (element.attr("id") == "alacrity" && parseInt($("#weapon-expertise .current").text()) >= 1) { return false; }
	else if (element.attr("id") == "sorcery" && parseInt($("#arcane-knowledge .current").text()) >= 1) { return false; }
	else if (element.attr("id") == "durability" && parseInt($("#veterans-scars .current").text()) >= 1) { return false; }
	else if (element.attr("id") == "tough-skin" && parseInt($("#bladed-armor .current").text()) >= 1) { return false; }
	else if (element.attr("id") == "expanded-mind" && parseInt($("#meditation .current").text()) >= 1) { return false; }
	else if (element.attr("id") == "greed" && parseInt($("#wealth .current").text()) >= 1) { return false; }
	else { return true; }
};

// Checks to see if a point may be added according to Riot's point allotment rules.
function prerequisiteUp(element) {
	var row1 = 0;
	var row2 = 0;
	var row3 = 0;
	var row4 = 0;
	var row5 = 0;
	$("#" + element.parent().parent().attr("id") + " .masteries-1 .mastery .current").each(function() { row1 += parseInt($(this).text()); });
	$("#" + element.parent().parent().attr("id") + " .masteries-2 .mastery .current").each(function() { row2 += parseInt($(this).text()); });
	$("#" + element.parent().parent().attr("id") + " .masteries-3 .mastery .current").each(function() { row3 += parseInt($(this).text()); });
	$("#" + element.parent().parent().attr("id") + " .masteries-4 .mastery .current").each(function() { row4 += parseInt($(this).text()); });
	$("#" + element.parent().parent().attr("id") + " .masteries-5 .mastery .current").each(function() { row5 += parseInt($(this).text()); });
	if (element.parent().attr("class") == "masteries-1") { return true; }
	if (element.parent().attr("class") == "masteries-2") {			
		if (row1 >= 4) { return true; }
		else { return false; }
	};
	if (element.parent().attr("class") == "masteries-3") {			
		if (row1 + row2 >= 8) { return true; }
		else { return false; }
	};
	if (element.parent().attr("class") == "masteries-4") {			
		if (row1 + row2 + row3 >= 12) { return true; }
		else { return false; }
	};
	if (element.parent().attr("class") == "masteries-5") {			
		if (row1 + row2 + row3 + row4 >= 16) { return true; }
		else { return false; }
	};
	if (element.parent().attr("class") == "masteries-6") {			
		if (row1 + row2 + row3 + row4 + row5 >= 20) { return true; }
		else { return false; }
	};
}

// Checks to see if a point may be subtracted according to Riot's point allotment rules.
function prerequisiteDown(element) {
	var row1 = 0;
	var row2 = 0;
	var row3 = 0;
	var row4 = 0;
	var row5 = 0;
	var row6 = 0;
	$("#" + element.parent().parent().attr("id") + " .masteries-1 .mastery .current").each(function() { row1 += parseInt($(this).text()); });
	$("#" + element.parent().parent().attr("id") + " .masteries-2 .mastery .current").each(function() { row2 += parseInt($(this).text()); });
	$("#" + element.parent().parent().attr("id") + " .masteries-3 .mastery .current").each(function() { row3 += parseInt($(this).text()); });
	$("#" + element.parent().parent().attr("id") + " .masteries-4 .mastery .current").each(function() { row4 += parseInt($(this).text()); });
	$("#" + element.parent().parent().attr("id") + " .masteries-5 .mastery .current").each(function() { row5 += parseInt($(this).text()); });
	$("#" + element.parent().parent().attr("id") + " .masteries-6 .mastery .current").each(function() { row6 += parseInt($(this).text()); });
	
	if (element.parent().attr("class") == "masteries-1") {			
		if (row2 + row3 + row4 + row5 + row6 == 0) { return true; }
		else if (row1 > 4 && row3 + row4 + row5 + row6 == 0) { return true; }
		else if (row1 + row2 > 8 && row4 + row5 + row6 == 0) { return true; }
		else if (row1 + row2 + row3 > 12 && row5 + row6 == 0) { return true; }
		else if (row1 + row2 + row3 + row4 > 16 && row6 == 0) { return true; }
		else if (row1 + row2 + row3 + row4 + row5 > 20) { return true; }
		else { return false; }
	}
	if (element.parent().attr("class") == "masteries-2") {			
		if (row3 + row4 + row5 + row6 == 0) { return true; }
		else if (row1 + row2 > 8 && row4 + row5 + row6 == 0) { return true; }
		else if (row1 + row2 + row3 > 12 && row5 + row6 == 0) { return true; }
		else if (row1 + row2 + row3 + row4 > 16 && row6 == 0) { return true; }
		else if (row1 + row2 + row3 + row4 + row5 > 20) { return true; }
		else { return false; }
	}
	if (element.parent().attr("class") == "masteries-3") {			
		if (row4 + row5 + row6 == 0) { return true; }
		else if (row1 + row2 + row3 > 12 && row5 + row6 == 0) { return true; }
		else if (row1 + row2 + row3 + row4 > 16 && row6 == 0) { return true; }
		else if (row1 + row2 + row3 + row4 + row5 > 20) { return true; }
		else { return false; }
	}
	if (element.parent().attr("class") == "masteries-4") {			
		if (row5 + row6 == 0 ) { return true; }
		else if (row1 + row2 + row3 + row4 > 16 && row6 == 0) { return true; }
		else if (row1 + row2 + row3 + row4 + row5 > 20) { return true; }
		else { return false; }
	}
	if (element.parent().attr("class") == "masteries-5") {			
		if (row6 == 0) { return true; }
		else if (row1 + row2 + row3 + row4 + row5 > 20) { return true; }
		else { return false; }
	}
	if (element.parent().attr("class") == "masteries-6") { return true; }
}

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
}




function encodeString(str){
  var retval = '';
  for( var i=0; i < str.length; i+=2 ){
    if( typeof str[i] !== "undefined" && typeof str[i+1] !== "undefined" ){
      retval += encodeTable[ parseInt(str[i]) ][ parseInt(str[i+1])];
    }
    else{
      if(typeof str[i] !== "undefined") retval += str[i];
    }
  }
  return retval;
}

function decodeString(str){
  var retval = '';
  for( var i=0; i < str.length; i++ ){
    var dct = decodeTable[ str[i] ];
    if(typeof dct === "undefined") retval += str[i];
    else retval += dct;
  }
  return retval;
}

 
function updateHash(){
  var val = serializeValues();
  location.hash = val;
  $("#hash-url").val( location );
}

function processHash(){
  var hash = location.hash.substr(1);

  var vals = strToArray(hash);
  if( typeof vals["m"] !== "undefined" ){
    deserializeValues(vals["m"]);
  }
  
  $("#hash-url").val( location );
  
}

function strToArray(url) {
  var request = {};
  var pairs = url.split('&');
  for (var i = 0; i < pairs.length; i++) {
    var pair = pairs[i].split('=');
    request[decodeURIComponent(pair[0])] = decodeURIComponent(pair[1]);
  }
  return request;
}



function serializeValues(){
  var offensiveSum = '';
  var defensiveSum = '';
  var utilitySum = '';
  $("#masteries-offensive .current").each(function() {
		offensiveSum += $(this).text();
	});
	$("#masteries-defensive .current").each(function() {
		defensiveSum += $(this).text();
	});
	$("#masteries-utility .current").each(function() {
		utilitySum += $(this).text();
	});
	
  return ("m="+encodeString(offensiveSum) + "|" + encodeString(defensiveSum) + "|" + encodeString(utilitySum) );
}

function deserializeValues(str){
  var offensiveSum = '';
  var defensiveSum = '';
  var utilitySum = '';
  
  var vals = str.split("|");
  vals[0] = decodeString( vals[0] );
  vals[1] = decodeString( vals[1] );
  vals[2] = decodeString( vals[2] );
  
  $("#masteries-offensive .current").each(function(k, v) {
    var count = parseInt( vals[0][k] );
    while(count > 0){
      $(this).parent().click();
      count--;
    }
	});
	$("#masteries-defensive .current").each(function(k, v) {
    var count = parseInt( vals[1][k] );
    while(count > 0){
      $(this).parent().click();
      count--;
    }
	});
	$("#masteries-utility .current").each(function(k, v) {
    var count = parseInt( vals[2][k] );
    while(count > 0){
      $(this).parent().click();
      count--;
    }
	});
  
}

var encodeTable = [
  ["A", "B", "C", "D", "E"],
  ["F", "G", "H", "I", "J"],
  ["K", "L", "M", "N", "O"],
  ["P", "Q", "R", "S", "T"],
  ["U", "V", "W", "X", "Y"]
];

var decodeTable = {};
for(var i = 0; i < encodeTable.length; i++){
  for(var j = 0; j < encodeTable[i].length; j++ ){
    decodeTable[ encodeTable[i][j] ] = ""+i+j;
  }
}





