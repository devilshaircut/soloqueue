# file full non-wikia updating tasks
namespace :update do

  task :get_new_champions => :environment do
    page = Hpricot( HTTParty.get("http://na.leagueoflegends.com/champions") )
    page.search("table.champion_item td.description span.highlight a").each do |e|
      url = e.attributes["href"].split("/")
      
      champ = Champion.find_by_riot_id( url[2].to_i )
      if champ.nil?
        puts "Creating New Champion -- #{url.inspect}"
        Rails.logger.debug "Creating New Champion -- #{url.inspect}"
        Champion.create( :riot_id => url[2].to_i )
      end
    end
  end

  task :champions => :environment do
    Champion.each do |c|
      c.updateChampData!
    end
  end
  
  task :attributes => :environment do
  
    url = Hpricot( HTTParty.get("http://na.leagueoflegends.com/champions") ).search(".champion_item")
  
    url.each do |a|
      champName = a.search(".highlight a").inner_html
      attack = a.search(".filled_attack").to_a.count
      health = a.search(".filled_health").to_a.count
      difficulty = a.search(".filled_difficulty").to_a.count
      spells = a.search(".filled_spells").to_a.count

      stats = [ attack, health, difficulty, spells ].to_json
      champ = Champion.find_by_name(champName)
      champ.attributes_table = stats
      champ.save
    end
  
  end

end