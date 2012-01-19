var first_character = null;
function search (search_input, is_url_search) {
  if (search_input.length == 0) {
    $("#auto-complete").html('').hide();
    $('header').animate({
      marginTop: 200
    }, 300, function () {   
      $("#data-found").html('').hide();
      $(this).find('p').show();
    });
  }
  else {
    var champions_and_items = ["Ahri","Akali","Alistar","Amumu","Anivia","Annie","Ashe","Blitzcrank","Brand","Caitlyn","Cassiopeia","Cho'Gath","Corki","Dr. Mundo","Evelynn","Ezreal","Fiddlesticks","Fizz","Galio","Gangplank","Garen","Gragas","Graves","Heimerdinger","Irelia","Janna","Jarvan IV","Jax","Karma","Karthus","Kassadin","Katarina","Kayle","Kennen","Kog'Maw","LeBlanc","Lee Sin","Leona","Lux","Malphite","Malzahar","Maokai","Master Yi","Miss Fortune","Mordekaiser","Morgana","Nasus","Nidalee","Nocturne","Nunu","Olaf","Orianna","Pantheon","Poppy","Rammus","Renekton","Riven","Rumble","Ryze","","Shaco","Shen","Shyvana","Singed","Sion","Sivir","Skarner","Sona","Soraka","Swain","Talon","Taric","Teemo","Tristana","Trundle","Tryndamere","Twisted Fate","Twitch","Udyr","Urgot","Vayne","Veigar","Viktor","Vladimir","Volibear","Warwick","Wukong","Xerath","Xin Zhao","Yorick","Zilean","Abyssal Scepter","Aegis of the Legion","Amplifying Tome","Ancient Pocket Watch","Archangel's Staff","Atma's Impaler","Avarice Blade","B.F. Sword","Bag of Tea","Banshee's Veil","Berserker's Greaves","Bilgewater Cutlass‎","Blasting Wand","Blue Pill","Boots of Mobility","Boots of Speed","Boots of Swiftness","Brawler's Gloves","Breathstealer","Catalyst the Protector","Chain Vest","Chalice of Harmony","Cloak and Dagger","Cloak of Agility","Cloth Armor","Dagger","Deathfire Grasp","Doran's Blade","Doran's Ring","Doran's Shield","Eleisa's Miracle","Elixir of Agility","Elixir of Brilliance","Elixir of Fortitude","Emblem of Valor","Entropy","Executioner's Calling","Faerie Charm","Fiendish Codex","Force of Nature","Frozen Heart","Frozen Mallet","Giant's Belt","Glacial Shroud","Guardian Angel","Guinsoo's Rageblade","Haunting Guise","Health Potion","Heart of Gold","Hexdrinker‎","Hextech Gunblade‎","Hextech Revolver‎","Hextech Sweeper","Infinity Edge","Innervating Locket","Ionian Boots of Lucidity","Ionic Spark","Kage's Lucky Pick","Kindlegem","Kitae's Bloodrazor","Last Whisper","Leviathan","Lich Bane","Long Sword","Madred's Bloodrazor","Madred's Razors","Malady","Mana Manipulator","Mana Potion","Manamune","Marksman's Rifle","Mejai's Soulstealer","Meki Pendant","Mercury's Treads","Moonflair Spellblade","Morello's Evil Tome","Nashor's Tooth","Needlessly Large Rod","Negatron Cloak","Ninja Tabi","Null-Magic Mantle","Odyn's Veil","Oracle's Elixir","Oracle's Extract","Oracle's Hood","Phage","Phantom Dancer","Philosopher's Stone","Pickaxe","Priscilla's Blessing","Prospector's Blade","Prospector's Ring","Quicksilver Sash","Rabadon's Deathcap","Randuin's Omen","Recurve Bow","Regrowth Pendant","Rejuvenation Bead","Rod of Ages","Ruby Crystal","Rylai's Crystal Scepter","Sage's Ring","Sanguine Blade","Sapphire Crystal","Sheen","Shurelya's Reverie","Sight Ward","Sorcerer's Shoes","Soul Shroud","Spirit Visage","Stark's Fervor","Stinger","Sunfire Cape","Sword of the Divine","Sword of the Occult","Tear of the Goddess","The Black Cleaver","The Bloodthirster","The Brutalizer","The Lightbringer","Thornmail","Tiamat","Trinity Force","Vampiric Scepter","Vision Ward","Void Staff","Warden's Mail","Warmog's Armor","Will of the Ancients","Wit's End","Wriggle's Lantern","Yordle Stompers","Youmuu's Ghostblade","Zeal","Zhonya's Hourglass","Zhonya's Ring"];
    var auto_complete = $("#auto-complete").html('');
  
    first_character = search_input.charAt(0);
  
    for (var i = 0; i < champions_and_items.length; i++) {
      if (!is_url_search) {
        auto_complete.show();
      
        if (champions_and_items[i].replace(/[.,\-'"]/g,'').toLowerCase().indexOf(search_input.replace(/[.,\-'"]/g,'').toLowerCase()) < 0) {
          auto_complete.remove("#" + i);
        }
        else {
          auto_complete.append("<li id='" + i + "'>" + champions_and_items[i] + "</li>");
        }

        window.location.hash = '#'+search_input;
      }
      else {
        $('#search').val(search_input.replace(/%20/g," ").replace(/[+]/g," "));
      }
      
      if (i+1 == champions_and_items.length && search_input.length >= 2) {
        get_data(search_input.replace(/[+]/g," "));
      }
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
    
    var api_url = "/api/"+search.replace(/[.,\-'"]/g,'')+".json";
    query = $.getJSON(api_url, function (data) {
      console.log(data);
      _gaq.push(['_trackPageview', api_url]);  // google analytics track api pageview
      $("#search").removeClass('loading');
      
      $('header').find('p').hide();
      $('#search-data').show();
      
      if (data.data.length == 0) {
        $('#data-found').hide();
        $('#no-data').show();
      }
      else {
        $('#no-data').hide();
        $('#data-found').show().html('');
        
        $('header').animate({
          marginTop: 20
        }, 300, function () { 
          $.each(data.data, function (k,v) {
            var newTemplate = $('.original-template').clone().removeClass('original-template');
            var tempParent = $("#counter-picks", newTemplate);

            newTemplate.find("h2").parent().attr('href', '#' + this[0].replace(/_/g," "));
            newTemplate.find("h2").html(this[0].replace(/_/g," "));

            
            if (this[1].counters != null) {
              
              // Curated Counterpicks
              var countersTemplate = newTemplate.find("#counterpicks-forums ul");
              var counter_picks_html = "";
              $.each(this[1].counters.curated, function () {
                counter_picks_html += "<li>" + this.toString() + "</li>";
              });
              countersTemplate.html(counter_picks_html);
              
              
              // Voted Counterpicks
              var countersTemplate = newTemplate.find("#counterpicks-community ul");
              var counter_picks_html = "";
              $.each(this[1].counters.community, function () {
                var reason = this[1];
                if(reason.length > 0){
                  reason = ": "+reason;
                }
                
                counter_picks_html += "<li>" + this[0] + reason + "</li>";
              });
              countersTemplate.html(counter_picks_html);
              
              
              // Voting Section
              $("#counterpicks-vote .vote-champ-name", newTemplate).val( v[0] );
              if( this[1].counters.votes.logged_in === "true" || this[1].counters.votes.logged_in === true){
                tempParent.find(".logged-out").removeClass("logged-out").addClass("logged-in");
                
                var counterpick_rows = $("#counterpicks-vote ul li", newTemplate);
                if( typeof this[1].counters.votes.values !== "undefined"){
                  $.each(this[1].counters.votes.values, function(k,v){
                    counterpick_rows.eq(k).find(".counterpick-name").val(v.counterpick_id);
                    counterpick_rows.eq(k).find(".counterpick-reason").val(v.reason_id);
                  });
                }
                
                newTemplate.find(".vote-save").click(function(event){
                  var data = $(this).parent().serializeArray();
                  
                  var spinner = new Spinner({
                    lines: 8, // The number of lines to draw
                    length: 5, // The length of each line
                    width: 3, // The line thickness
                    radius: 2, // The radius of the inner circle
                    color: '#fff', // #rgb or #rrggbb
                    speed: 0.8, // Rounds per second
                    trail: 39, // Afterglow percentage
                    shadow: false // Whether to render a shadow
                  }).spin(newTemplate.find(".spinner").show()[0]);
                  
                  $.ajax({
                    type: 'POST',
                    url: '/vote.json',
                    data: data,
                    success: function(data){
                      newTemplate.find(".spinner").hide();
                    }, 
                    error: function(data){
                      newTemplate.find(".spinner").hide();
                    }
                  }); 
                  event.preventDefault();
                  return false;
                  
                });
                
              }
              
            }
            else {
              tempParent.remove();
            }

            newTemplate.find("#general-data #data").html(this[1].wiki);

            $('#data-found').append(newTemplate);

            // bullshit manipulate the data returned by wikia -cody
            var innate_ability = newTemplate.find('.innate_ability');
            innate_ability.remove();
            innate_ability.find('.abilityinfo').attr('colspan',1);
            innate_ability.append("<td></td>");
            innate_ability.insertAfter(newTemplate.find("#general-data #data .ability_header"));
            
            var item_icon = null;
            if (this[1].counters == null) {
              original_item_icon = newTemplate.find(".infobox tr:nth-child(2) img");
              item_icon = original_item_icon.clone();
              original_item_icon.remove();
              newTemplate.find('h2').prepend(item_icon);
            }
            else {
              var visualBars = "";
              $(newTemplate.find('table')[1]).find('tr').each(function () {
                visualBars += $(this).html();
              });
              $(newTemplate.find('table')[1]).html(visualBars);
              newTemplate.find('h2').prepend("<img src='/assets/champs/" + this[0].replace(/[.,\-'"]/g,'').replace(" ", "_") + ".jpg' />");
            }
            // end bullshit will be removed when we own our own data ^_^

            newTemplate.addClass(this[0].replace(/[.,\-'" ]/g,'').toLowerCase());

            search_cache.push(this[0]);
          });
        });
      }
    });
  }
}

function url_search () {
  search(window.location.hash.substr(1), true);
}

$(document).ready(function () {
  $('html').delegate('.url-search-link', 'click', function () {
    window.location.hash = '#'+$(this).find('h2').text();
    url_search();
  });
  
  $(document).click(function(event) {
    if (event.target.id != "search") $('#auto-complete').html("").hide();
  });
  
  var timer;
  $("#search").keyup(function (e) {
    if (e.keyCode == 8 || $(this).val()[0] != first_character) {
      search_cache = [];
    }
  
    clearTimeout(timer);
    var search_input = $(this).val();
    timer = setTimeout(function () {
      search(search_input, false);
    }, 500);
  });
  
  $("#search").focus(function () {
    if ($(this).val().length >= 2) search($(this).val(), false);
  });
  
  $("#auto-complete").delegate("li", "click", function () {
    var clicked_li = $(this);
    window.location.hash = clicked_li.html();
    search_cache = [];
    $("#search").val(clicked_li.html());
    get_data(clicked_li.html());
    $("#auto-complete").html("").hide();
  });
  
  //$("#counter-picks select").chosen();
  
  
  
});