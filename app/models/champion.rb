class Champion < ActiveRecord::Base
  
  has_many :votes
  has_many :counterpicks, :through => :votes, :source => :counterpick
  # ^^^ this relationship means you can do Champion.find(1).counterpicks  and it will return all champs voted as counterpicks.
  
  def self.updateChampData
    Champion.all.each do |s|
      url = Hpricot( HTTParty.get("http://na.leagueoflegends.com/champions/" + s.riot_id.to_s) )
      s.champion_full_name =        url.search("h2 span.champion_name").to_s + " " + url.search("h2 span.champion_title").to_s
      s.damage =                    url.search("table.stats_table:nth-child(1) .stats_value")
      s.damage_per_level =          url.search("table.stats_table:nth-child(1) .ability_per_level_stat")
      s.health =                    url.search("table.stats_table:nth-child(2) .stats_value")
      s.health_per_level =          url.search("table.stats_table:nth-child(2) .ability_per_level_stat")
      s.resource =                  url.search("table.stats_table:nth-child(3) .stats_value")
      s.resource_per_level =        url.search("table.stats_table:nth-child(3) .ability_per_level_stat")
      s.move_speed =                url.search("table.stats_table:nth-child(4) .stats_value")
      s.armor =                     url.search("table.stats_table:nth-child(5) .stats_value")
      s.armor_per_level =           url.search("table.stats_table:nth-child(5) .ability_per_level_stat")
      s.magic_resist =              url.search("table.stats_table:nth-child(6) .stats_value")
      s.magic_resist_per_level =    url.search("table.stats_table:nth-child(6) .ability_per_level_stat")
      s.health_regen =              url.search("table.stats_table:nth-child(7) .stats_value")
      s.health_regen_per_level =    url.search("table.stats_table:nth-child(7) .ability_per_level_stat")
      s.resource_regen =            url.search("table.stats_table:nth-child(8) .stats_value")
      s.resource_regen_per_level =  url.search("table.stats_table:nth-child(8) .ability_per_level_stat")
      s.save
    end
  end
  
end
