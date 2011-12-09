function search (search_input) {
  var champions_array   = ["Akali", "Alistar", "Amumu", "Anivia", "Annie", "Ashe", "Blitzcrank", "Brand", "Caitlyn", "Cassiopeia", "Cho'Gath", "Corki", "Dr. Mundo", "Evelynn", "Ezreal", "Fiddlesticks", "Galio", "Gangplank", "Garen", "Gragas", "Heimerdinger", "Irelia", "Janna", "Jarvan IV", "Jax", "Karma", "Karthus", "Kassadin", "Katarina", "Kayle", "Kennen", "Kog'Maw", "LeBlanc", "Lee Sin", "Leona", "Lux", "Malphite", "Malzahar", "Maokai", "Master Yi", "Miss Fortune", "Mordekaiser", "Morgana", "Nasus", "Nidalee", "Nocturne", "Nunu", "Olaf", "Orianna", "Pantheon", "Poppy", "Rammus", "Renekton", "Riven", "Rumble", "Ryze", "Shaco", "Shen", "Singed", "Sion", "Sivir", "Skarner", "Sona", "Soraka", "Swain", "Talon", "Taric", "Teemo", "Tristana", "Trundle", "Tryndamere", "Twisted Fate", "Twitch", "Udyr", "Urgot", "Vayne", "Veigar", "Vladimir", "Warwick", "Wukong", "Xerath", "Xin Zhao", "Yorick", "Zilean"];
  var champions_list    = $("#champions");
  
  for (var i = 0; i < champions_array.length; i++) {
    if (champions_array[i].toLowerCase().indexOf(search_input.toLowerCase()) < 0) {
      champions_list.find("#" + (i+1)).hide();
    }
    else {
      champions_list.find("#" + (i+1)).show();
    }
  }
}

function set_search (champion_id, champion_name) {
  $("#search").val(champion_name);
  $("#champions li").hide();
  get_counter_picks(champion_name);
}

function get_counter_picks (champion_name) {
  counter_picks       = $("#counter-picks");
  counter_picks_list  = counter_picks.find("ol");
  
  counter_picks.show()
  counter_picks_list.html("");
  
  counter_picks.find("h3").html(champion_name + " Counter Picks");
  
  $.getJSON("/champion/"+champion_name+".json", function (data) {
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
  
  $("#champions").delegate("li", "click", function () {
    set_search($(this).attr("id"), $(this).html());
  });
});