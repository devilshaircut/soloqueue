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
  get_counter_picks(search_input);
}

function get_counter_picks (search_input) {
  counter_picks       = $("#counter-picks");
  counter_picks_list  = counter_picks.find("ol");
  
  counter_picks.show()
  counter_picks_list.html("");
  
  $.getJSON("/champion/"+search_input, function (data) {
    if (data["counters"] == null) {
      counter_picks_list.append("Champion not found.");
    }
    else {
      $.each(data["counters"], function () {
        counter_picks_list.append("<li>" + this.toString() + "</li>");
      });
    }
  });
}

$(document).ready(function () {
  var timer;
  $("#search").keyup(function (e) {
    clearTimeout(timer);
    if (e.keyCode != 13) {
      var search_input = $(this).val();
      timer = setTimeout(function () {
        search(search_input);
      }, 500);
    }
    else {
      set_search($(this).val());
    }
  });
  
  $("#search-results").delegate("li", "click", function () {
    set_search($(this).html());
  });
});