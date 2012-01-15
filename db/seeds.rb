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
