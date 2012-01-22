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

end