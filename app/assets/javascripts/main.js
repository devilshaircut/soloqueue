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

function get_data (champion_name) {
  $("#current-search-header").html(champion_name);
  
  $.getJSON("/champion/"+champion_name+".json", function (data) {
    $('#welcome').hide();
    $('#search-data').fadeIn(100);
    
    if (data["counters"] == null && data["wiki"] == null) {
      $('data-found').hide();
      $('#no-data').show();
    }
    else {
      $('#no-data').hide();
      $('#data-found').show();
      
      var counter_picks_html  = "";
      var general_data        = data["wiki"];
      
      $.each(data["counters"], function () {
        counter_picks_html += "<li>" + this.toString() + "</li>";
      });
      
      $("#counter-picks ol").html(counter_picks_html)
      $("#general-data #data").html(general_data);
      
      // bullshit manipulate the data returned by wikia -cody
      var innate_ability = $('.innate_ability');
      $(".innate_ability").remove();
      innate_ability.find('.abilityinfo').attr('colspan',1);
      innate_ability.append("<td></td>");
      innate_ability.insertAfter($("#general-data #data .ability_header"));
      $("#general-data #data span").each(function () {
        if ($(this).css('color') == 'rgb(151, 252, 151)') {
          $(this).css('color','green');
        }
      });
      // end bullshit will be removed when we own our own data ^_^
    }
  });
}

function setListHolderHeight () {
  $("#list-holder").height($(window).height()-132 + "px");
}

$(document).ready(function () {
  // stylish animation shit
  $('#soloqueue').click(function () {
    $('#search-data').fadeOut(100, function () {
      $('#welcome').fadeIn(100);
    });
  });
  
  $('body').fadeIn(500);
  // end bull shit

  setListHolderHeight();
  $(window).resize(function () {
    setListHolderHeight();
  });
  
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
      get_data($(this).val());
    }
  });
  
  $("#champions").delegate("li", "click", function () {
    $("#champions li").removeClass('active');
    $(this).addClass('active');
    get_data($(this).html());
  });
});