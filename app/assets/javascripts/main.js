function search (search_input) {
  $("#list-holder li").removeClass('active');
  
  var champions_and_items = ["Ahri","Akali","Alistar","Amumu","Anivia","Annie","Ashe","Blitzcrank","Brand","Caitlyn","Cassiopeia","Cho'Gath","Corki","Dr. Mundo","Evelynn","Ezreal","Fiddlesticks","Fizz","Galio","Gangplank","Garen","Gragas","Graves","Heimerdinger","Irelia","Janna","Jarvan IV","Jax","Karma","Karthus","Kassadin","Katarina","Kayle","Kennen","Kog'Maw","LeBlanc","Lee Sin","Leona","Lux","Malphite","Malzahar","Maokai","Master Yi","Miss Fortune","Mordekaiser","Morgana","Nasus","Nidalee","Nocturne","Nunu","Olaf","Orianna","Pantheon","Poppy","Rammus","Renekton","Riven","Rumble","Ryze","Shaco","Shen","Shyvana","Singed","Sion","Sivir","Skarner","Sona","Soraka","Swain","Talon","Taric","Teemo","Tristana","Trundle","Tryndamere","Twisted Fate","Twitch","Udyr","Urgot","Vayne","Veigar","Vladimir","Volibear","Warwick","Wukong","Xerath","Xin Zhao","Yorick","Zilean","Abyssal Scepter","Aegis of the Legion","Amplifying Tome","Ancient Pocket Watch","Archangel's Staff","Atma's Impaler","Avarice Blade","B.F. Sword","Bag of Tea","Banshee's Veil","Berserker's Greaves","Bilgewater Cutlass‎","Blasting Wand","Blue Pill","Boots of Mobility","Boots of Speed","Boots of Swiftness","Brawler's Gloves","Breathstealer","Catalyst the Protector","Chain Vest","Chalice of Harmony","Cloak and Dagger","Cloak of Agility","Cloth Armor","Dagger","Deathfire Grasp","Doran's Blade","Doran's Ring","Doran's Shield","Eleisa's Miracle","Elixir of Agility","Elixir of Brilliance","Elixir of Fortitude","Emblem of Valor","Entropy","Executioner's Calling","Faerie Charm","Fiendish Codex","Force of Nature","Frozen Heart","Frozen Mallet","Giant's Belt","Glacial Shroud","Guardian Angel","Guinsoo's Rageblade","Haunting Guise","Health Potion","Heart of Gold","Hexdrinker‎","Hextech Gunblade‎","Hextech Revolver‎","Hextech Sweeper","Infinity Edge","Innervating Locket","Ionian Boots of Lucidity","Ionic Spark","Kage's Lucky Pick","Kindlegem","Kitae's Bloodrazor","Last Whisper","Leviathan","Lich Bane","Long Sword","Madred's Bloodrazor","Madred's Razors","Malady","Mana Manipulator","Mana Potion","Manamune","Marksman's Rifle","Mejai's Soulstealer","Meki Pendant","Mercury's Treads","Moonflair Spellblade","Morello's Evil Tome","Nashor's Tooth","Needlessly Large Rod","Negatron Cloak","Ninja Tabi","Null-Magic Mantle","Odyn's Veil","Oracle's Elixir","Oracle's Extract","Oracle's Hood","Phage","Phantom Dancer","Philosopher's Stone","Pickaxe","Priscilla's Blessing","Prospector's Blade","Prospector's Ring","Quicksilver Sash","Rabadon's Deathcap","Randuin's Omen","Recurve Bow","Regrowth Pendant","Rejuvenation Bead","Rod of Ages","Ruby Crystal","Rylai's Crystal Scepter","Sage's Ring","Sanguine Blade","Sapphire Crystal","Sheen","Shurelya's Reverie","Sight Ward","Sorcerer's Shoes","Soul Shroud","Spirit Visage","Stark's Fervor","Stinger","Sunfire Cape","Sword of the Divine","Sword of the Occult","Tear of the Goddess","The Black Cleaver","The Bloodthirster","The Brutalizer","The Lightbringer","Thornmail","Tiamat","Trinity Force","Vampiric Scepter","Vision Ward","Void Staff","Warden's Mail","Warmog's Armor","Will of the Ancients","Wit's End","Wriggle's Lantern","Yordle Stompers","Youmuu's Ghostblade","Zeal","Zhonya's Hourglass","Zhonya's Ring"];
  var champions_list = $("#champions");
  var items_list = $("#items");
  
  for (var i = 0; i < champions_and_items.length; i++) {
    if (champions_and_items[i].replace(/[.,\-'"]/g,'').toLowerCase().indexOf(search_input.replace(/[.,\-'"]/g,'').toLowerCase()) < 0) {
      champions_list.find("#" + (i+1)).hide();
      items_list.find("#" + (i+1)).hide();
    }
    else {
      champions_list.find("#" + (i+1)).show();
      items_list.find("#" + (i+1)).show();
    }
    
    if (i+1 == champions_and_items.length && search_input.length >= 2) {
      get_data(search_input);
    }
  }
}

var query = "";
var search_cache = [];
function get_data (search) {
  if (search_cache.length > 0) {
    for (var i = 0; i < search_cache.length; i++) {
      if (search_cache[i].replace(/[.,\-'"]/g,'').toLowerCase().indexOf(search.replace(/[.,\-'"]/g,'').toLowerCase()) == -1 && search_cache[i] != "") {
        $('.' + search_cache[i].replace(/[.,\-'" ]/g,'').toLowerCase()).remove();
        search_cache[i] = "";
      }
    }
    
  }
  else {
    if (query != "") query.abort();
    $("#current-search-header").html(search);
  
    $("#search").addClass('loading');
    query = $.getJSON("/api/"+search.replace(/[.,\-'"]/g,'')+".json", function (data) {
      $("#search").removeClass('loading');
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
            var counter_picks_html = "";
          
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
        
          // bullshit manipulate the data returned by wikia -cody
          var innate_ability = newTemplate.find('.innate_ability');
          innate_ability.remove();
          innate_ability.find('.abilityinfo').attr('colspan',1);
          innate_ability.append("<td></td>");
          innate_ability.insertAfter(newTemplate.find("#general-data #data .ability_header"));
        
          $("#general-data #data span").each(function () {
            if ($(this).css('color') == 'rgb(151, 252, 151)') {
              $(this).css('color','green');
            }
          });
        
          var item_icon = null;
          if (this[1].counters == null) {
            original_item_icon = newTemplate.find(".infobox tr:nth-child(2) img");
            item_icon = original_item_icon.clone();
            original_item_icon.remove();
            newTemplate.find('h2').prepend(item_icon);
          }
          else {
            newTemplate.find('h2').prepend("<img src='/assets/champs/" + this[0].replace(/[.,\-'"]/g,'').replace(" ", "_") + ".jpg' />");
          }
          // end bullshit will be removed when we own our own data ^_^
          
          newTemplate.addClass(this[0].replace(/[.,\-'" ]/g,'').toLowerCase());
          
          search_cache.push(this[0]);
        });
      }
    });
  }
}

function setListHolderHeight () {
  var new_height = $(window).height()-94 + "px";
  $("#list-holder").height(new_height);
  $(".slimScrollDiv").height(new_height);
}

$(document).ready(function () {
  $('#list-holder').slimScroll({
      height: $(window).height()-94 + "px",
      width: '206px'
  });
  
  // stylish animation shit
  $('#left-section').delay(500).fadeIn(500, function () {
    $("#search").focus();
  });
  $('#right-section').delay(500).fadeIn(500);
  // end bull shit

  setListHolderHeight();
  $(window).resize(function () {
    setListHolderHeight();
  });
  
  var timer;
  $("#search").keyup(function (e) {
    if (e.keyCode == 8) {
      search_cache = [];
    }
    
    clearTimeout(timer);
    var search_input = $(this).val();
    timer = setTimeout(function () {
      search(search_input);
    }, 500);
  });
  
  $("#list-holder").delegate("li", "click", function () {
    search_cache = [];
    $("#search").val($(this).html());
    $("#list-holder li").removeClass('active');
    $(this).addClass('active');
    get_data($(this).html());
  });
});