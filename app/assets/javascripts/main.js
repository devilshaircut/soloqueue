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
    if (i+1 == champions_array.length && search_input.length >= 2) {
      console.log(search_input);
      get_data(search_input);
    }
  }
}

function get_data (search) {
  $("#current-search-header").html(search);
  
  $.getJSON("/api/"+search+".json", function (data) {
    $('#welcome').hide();
    $('#search-data').fadeIn(100);
    
    if (data.data.length == 0) {
      $('#data-found').hide();
      $('#no-data').show();
    }
    else {
      $('#no-data').hide();
      $('#data-found').show();
      
      $('#data-found').html('');
      
      $.each(data.data, function () {
        var newTemplate = $('.original-template').clone().removeClass('original-template');
        
        newTemplate.find("h2").html(this[0].replace(/_/g," "));
        
        var countersTemplate = newTemplate.find("#counter-picks ol");
        if (this[1].counters != null) {
          var counter_picks_html  = "";
          
          $.each(this[1].counters, function () {
            counter_picks_html += "<li>" + this.toString() + "</li>";
          });
          
          countersTemplate.html(counter_picks_html);
        }
        else {
          countersTemplate.parent().remove();
        }

        newTemplate.find("#general-data #data").html(this[1].wiki);
        
        $('#data-found').append(newTemplate);
      });
      
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
  
  $('#left-section').delay(500).fadeIn(500);
  $('#right-section').delay(500).fadeIn(500);
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
      if ($(this).val().length <= 2) {
      } 
      else {
        get_data($(this).val());
      }
    }
  });
  
  $("#champions").delegate("li", "click", function () {
    $("#champions li").removeClass('active');
    $(this).addClass('active');
    get_data($(this).html());
  });
});