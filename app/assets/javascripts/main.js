function search (search_input) {
  var champs  = ["Akali", "Alistar", "Amumu", "Anivia", "Annie", "Ashe", "Blitzcrank", "Brand", "Caitlyn", "Cassiopeia", "Cho'Gath", "Corki", "Dr. Mundo", "Evelynn", "Ezreal", "Fiddlesticks", "Galio", "Gangplank", "Garen", "Gragas", "Heimerdinger", "Irelia", "Janna", "Jarvan IV", "Jax", "Karma", "Karthus", "Kassadin", "Katarina", "Kayle", "Kennen", "Kog'Maw", "LeBlanc", "Lee Sin", "Leona", "Lux", "Malphite", "Malzahar", "Maokai", "Master Yi", "Miss Fortune", "Mordekaiser", "Morgana", "Nasus", "Nidalee", "Nocturne", "Nunu", "Olaf", "Orianna", "Pantheon", "Poppy", "Rammus", "Renekton", "Riven", "Rumble", "Ryze", "Shaco", "Shen", "Singed", "Sion", "Sivir", "Skarner", "Sona", "Soraka", "Swain", "Talon", "Taric", "Teemo", "Tristana", "Trundle", "Tryndamere", "Twisted Fate", "Twitch", "Udyr", "Urgot", "Vayne", "Veigar", "Vladimir", "Warwick", "Wukong", "Xerath", "Xin Zhao", "Yorick", "Zilean"];
  var search_results = $("#search-results");

  for (var i = 0; i < champs.length; i++) {
    if (champs[i].toLowerCase().indexOf(search_input.toLowerCase()) != -1) {
     if (search_results.find("#" + i).length != 1) {
       search_results.append("<li id='" + i + "'>" + champs[i] + "</li>"); 
     }
    }
    else {
      search_results.find("#" + i).remove();
    }
  }
  
  if (search_results.length > 0) {
    search_results.show();
    
    $(document).click(function(){
      hide_results();
    });
  }
  else {
    hide_results();
  }
}

function hide_results () {
  $("#search-results").hide();
  $(document).unbind("click");
}

function set_search (search_input) {
  $("#search").val(search_input);
  $("#search-results").html('').hide();
  // $.getJSON();
}

$(document).ready(function () {
  var timer;
  $("#search").keyup(function () {
    clearTimeout(timer);
    var search_input = $(this).val();
    timer = setTimeout(function () {
      search(search_input);
    }, 500);
  });
  
  $("#search-results").delegate("li", "click", function () {
    set_search($(this).html());
  });
});