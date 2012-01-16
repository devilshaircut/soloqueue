# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(:email=>"admin@soloqueue.com", :password=>"daysprout123")

# Get all champ names from LOL page
# can also parse other attributes here later
page = Hpricot( HTTParty.get("http://na.leagueoflegends.com/champions") )
page.search("table.champion_item td.description span.highlight a").each do |e|
  Champion.create( :name=> e.inner_html)
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


