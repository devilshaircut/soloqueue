# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(:id => 1, :email=>"admin@soloqueue.com", :password=>"daysprout123")


Champion.create([
  [:id=>1, :name=>'Ahri'],
  [:id=>2, :name=>'Akali'],
  [:id=>3, :name=>'Alistar'],
  [:id=>4, :name=>'Amumu'],
  [:id=>5, :name=>'Anivia'],
  [:id=>6, :name=>'Annie'],
  [:id=>7, :name=>'Ashe'],
  [:id=>8, :name=>'Blitzcrank'],
  [:id=>9, :name=>'Brand'],
  [:id=>10, :name=>'Caitlyn'],
  [:id=>11, :name=>'Cassiopeia'],
  [:id=>12, :name=>'Cho\'Gath'],
  [:id=>13, :name=>'Corki'],
  [:id=>14, :name=>'Dr. Mundo'],
  [:id=>15, :name=>'Evelynn'],
  [:id=>16, :name=>'Ezreal'],
  [:id=>17, :name=>'Fiddlesticks'],
  [:id=>18, :name=>'Fizz'],
  [:id=>19, :name=>'Galio'],
  [:id=>20, :name=>'Gangplank'],
  [:id=>21, :name=>'Garen'],
  [:id=>22, :name=>'Gragas'],
  [:id=>23, :name=>'Graves'],
  [:id=>24, :name=>'Heimerdinger'],
  [:id=>25, :name=>'Irelia'],
  [:id=>26, :name=>'Janna'],
  [:id=>27, :name=>'Jarvan IV'],
  [:id=>28, :name=>'Jax'],
  [:id=>29, :name=>'Karma'],
  [:id=>30, :name=>'Karthus'],
  [:id=>31, :name=>'Kassadin'],
  [:id=>32, :name=>'Katarina'],
  [:id=>33, :name=>'Kayle'],
  [:id=>34, :name=>'Kennen'],
  [:id=>35, :name=>'Kog\'Maw'],
  [:id=>36, :name=>'LeBlanc'],
  [:id=>37, :name=>'Lee Sin'],
  [:id=>38, :name=>'Leona'],
  [:id=>39, :name=>'Lux'],
  [:id=>40, :name=>'Malphite'],
  [:id=>41, :name=>'Malzahar'],
  [:id=>42, :name=>'Maokai'],
  [:id=>43, :name=>'Master Yi'],
  [:id=>44, :name=>'Miss Fortune'],
  [:id=>45, :name=>'Mordekaiser'],
  [:id=>46, :name=>'Morgana'],
  [:id=>47, :name=>'Nasus'],
  [:id=>48, :name=>'Nidalee'],
  [:id=>49, :name=>'Nocturne'],
  [:id=>50, :name=>'Nunu'],
  [:id=>51, :name=>'Olaf'],
  [:id=>52, :name=>'Orianna'],
  [:id=>53, :name=>'Pantheon'],
  [:id=>54, :name=>'Poppy'],
  [:id=>55, :name=>'Rammus'],
  [:id=>56, :name=>'Renekton'],
  [:id=>57, :name=>'Riven'],
  [:id=>58, :name=>'Rumble'],
  [:id=>59, :name=>'Ryze'],
  [:id=>60, :name=>'Sejuani'],
  [:id=>61, :name=>'Shaco'],
  [:id=>62, :name=>'Shen'],
  [:id=>63, :name=>'Shyvana'],
  [:id=>64, :name=>'Singed'],
  [:id=>65, :name=>'Sion'],
  [:id=>66, :name=>'Sivir'],
  [:id=>67, :name=>'Skarner'],
  [:id=>68, :name=>'Sona'],
  [:id=>69, :name=>'Soraka'],
  [:id=>70, :name=>'Swain'],
  [:id=>71, :name=>'Talon'],
  [:id=>72, :name=>'Taric'],
  [:id=>73, :name=>'Teemo'],
  [:id=>74, :name=>'Tristana'],
  [:id=>75, :name=>'Trundle'],
  [:id=>76, :name=>'Tryndamere'],
  [:id=>77, :name=>'Twisted Fate'],
  [:id=>78, :name=>'Twitch'],
  [:id=>79, :name=>'Udyr'],
  [:id=>80, :name=>'Urgot'],
  [:id=>81, :name=>'Vayne'],
  [:id=>82, :name=>'Veigar'],
  [:id=>83, :name=>'Viktor'],
  [:id=>84, :name=>'Vladimir'],
  [:id=>85, :name=>'Volibear'],
  [:id=>86, :name=>'Warwick'],
  [:id=>87, :name=>'Wukong'],
  [:id=>88, :name=>'Xerath'],
  [:id=>89, :name=>'Xin Zhao'],
  [:id=>90, :name=>'Yorick'],
  [:id=>91, :name=>'Zilean']
])



page = Hpricot( HTTParty.get("http://na.leagueoflegends.com/champions") )
page.search("table.champion_item td.description span.highlight a").each do |e|
  url = e.attributes["href"].split("/")
  champ = Champion.find_by_name( e.inner_html )
  champ.riot_id = url[2].to_i
  champ.save
end 



Reason.create([
	[:id=>1, :title => "Stealth detection." ],
	[:id=>2, :title => "True damage." ],
	[:id=>3, :title => "Knock-back/knock-up." ],
	[:id=>4, :title => "Silence." ],
	[:id=>5, :title => "Stun." ],
	[:id=>6, :title => "Gap-closer." ],
	[:id=>7, :title => "Burst damage." ],
	[:id=>8, :title => "Spell shield." ],
	[:id=>9, :title => "Maneuverability/mobility." ],
	[:id=>10, :title => "Percent-life-based damage." ],
	[:id=>11, :title => "Durable/tanky." ],
	[:id=>12, :title => "Healing reduction." ],
	[:id=>13, :title => "Slows." ],
	[:id=>14, :title => "Long-range." ],
	[:id=>15, :title => "General crowd control." ],
	[:id=>16, :title => "Healing." ],
	[:id=>17, :title => "Strong early game." ],
	[:id=>18, :title => "Strong late game." ],
	[:id=>19, :title => "Harassing." ],
	[:id=>20, :title => "Deny farm." ],
	[:id=>21, :title => "Blink skills or wall-jumping." ],
	[:id=>22, :title => "Cleanse-like skills." ],
	[:id=>23, :title => "Attack speed reduction." ],
	[:id=>24, :title => "Lifesteal." ],
	[:id=>25, :title => "Map control." ],
	[:id=>26, :title => "Damage-over-time." ]
])

cc = CounterpickCache.find_by_id(1)
if cc.present?
  tmp = JSON.parse( cc.latestcounterpick )
  entriesList = tmp["feed"]["entry"]
  
  entriesList.each do | entry |
    champ = Champion.find_by_name( entry["title"] )
    
    if champ.present?
      counter = Champion.find_by_name( entry["_cokwr"] )
      if counter.present?
        Vote.create( :user_id => 1, :champion_id => champ.id, :counterpick_id => counter.id )
      end
    
      counter = Champion.find_by_name( entry["_cpzh4"] )
      if counter.present?
        Vote.create( :user_id => 1, :champion_id => champ.id, :counterpick_id => counter.id )
      end
    
      counter = Champion.find_by_name( entry["_cre1l"] )
      if counter.present?
        Vote.create( :user_id => 1, :champion_id => champ.id, :counterpick_id => counter.id )
      end
    end
  
  end
end


