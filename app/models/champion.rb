class Champion < ActiveRecord::Base
  
  has_many :votes
  has_many :counterpicks, :through => :votes, :source => :counterpick
  # ^^^ this relationship means you can do Champion.find(1).counterpicks  and it will return all champs voted as counterpicks.
  
  def updateChampData
    url = Hpricot( HTTParty.get("http://na.leagueoflegends.com/champions/" + riot_id.to_s) )
    champion_full_name =        url.search("h2 span.champion_name").to_s + " " + url.search("h2 span.champion_title").to_s
    damage =                    url.search("table.stats_table:nth-child(1) .stats_value")
    damage_per_level =          url.search("table.stats_table:nth-child(1) .ability_per_level_stat")
    health =                    url.search("table.stats_table:nth-child(2) .stats_value")
    health_per_level =          url.search("table.stats_table:nth-child(2) .ability_per_level_stat")
    resource =                  url.search("table.stats_table:nth-child(3) .stats_value")
    resource_per_level =        url.search("table.stats_table:nth-child(3) .ability_per_level_stat")
    move_speed =                url.search("table.stats_table:nth-child(4) .stats_value")
    armor =                     url.search("table.stats_table:nth-child(5) .stats_value")
    armor_per_level =           url.search("table.stats_table:nth-child(5) .ability_per_level_stat")
    magic_resist =              url.search("table.stats_table:nth-child(6) .stats_value")
    magic_resist_per_level =    url.search("table.stats_table:nth-child(6) .ability_per_level_stat")
    health_regen =              url.search("table.stats_table:nth-child(7) .stats_value")
    health_regen_per_level =    url.search("table.stats_table:nth-child(7) .ability_per_level_stat")
    resource_regen =            url.search("table.stats_table:nth-child(8) .stats_value")
    resource_regen_per_level =  url.search("table.stats_table:nth-child(8) .ability_per_level_stat")
    save
  end
  
end
