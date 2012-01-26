class Champion < ActiveRecord::Base
  has_many :skills
  has_many :votes
  has_many :counterpicks, :through => :votes, :source => :counterpick
  # ^^^ this relationship means you can do Champion.find(1).counterpicks  and it will return all champs voted as counterpicks.
  
  
  def updateChampData!
    updateChampData
    save
  end
  
  def updateChampData
    url = Hpricot( HTTParty.get("http://na.leagueoflegends.com/champions/" + self.riot_id.to_s) )
    self.champion_full_name =        url.search("h2 span.champion_name").inner_html.to_s + " " + url.search("h2 span.champion_title").inner_html.to_s
    self.damage =                    url.search(".view_content_frame .stats_table tr:nth-child(1) .stats_value").inner_html
    self.damage_per_level =          url.search(".view_content_frame .stats_table tr:nth-child(1) .ability_per_level_stat").inner_html.gsub(" / per level", "").gsub("+", "")
    self.health =                    url.search(".view_content_frame .stats_table tr:nth-child(2) .stats_value").inner_html
    self.health_per_level =          url.search(".view_content_frame .stats_table tr:nth-child(2) .ability_per_level_stat").inner_html.gsub(" / per level", "").gsub("+", "")
    self.resource =                  url.search(".view_content_frame .stats_table tr:nth-child(3) .stats_value").inner_html
    self.resource_per_level =        url.search(".view_content_frame .stats_table tr:nth-child(3) .ability_per_level_stat").inner_html.gsub(" / per level", "").gsub("+", "")
    self.move_speed =                url.search(".view_content_frame .stats_table tr:nth-child(4) .stats_value").inner_html
    self.armor =                     url.search(".view_content_frame .stats_table tr:nth-child(5) .stats_value").inner_html
    self.armor_per_level =           url.search(".view_content_frame .stats_table tr:nth-child(5) .ability_per_level_stat").inner_html.gsub(" / per level", "").gsub("+", "")
    self.magic_resist =              url.search(".view_content_frame .stats_table tr:nth-child(6) .stats_value").inner_html
    self.magic_resist_per_level =    url.search(".view_content_frame .stats_table tr:nth-child(6) .ability_per_level_stat").inner_html.gsub(" / per level", "").gsub("+", "")
    self.health_regen =              url.search(".view_content_frame .stats_table tr:nth-child(7) .stats_value").inner_html
    self.health_regen_per_level =    url.search(".view_content_frame .stats_table tr:nth-child(7) .ability_per_level_stat").inner_html.gsub(" / per level", "").gsub("+", "")
    self.resource_regen =            url.search(".view_content_frame .stats_table tr:nth-child(8) .stats_value").inner_html
    self.resource_regen_per_level =  url.search(".view_content_frame .stats_table tr:nth-child(8) .ability_per_level_stat").inner_html.gsub(" / per level", "").gsub("+", "")
    
    
    self.skills.delete_all
    url.search(".abilities_table tr").each do |tr|
      td = tr.search(".ability_detail")
      dd = td.search(".ability_stats dd")
      s = Skill.create({
        :name =>          td.search(".ability_name").inner_html,
        :description =>   td.search(".ability_description").inner_html,
        :effect =>        td.search(".ability_effect").inner_html,
        :cost =>          (dd.any? ? dd[0].inner_html : nil),
        :range =>         (dd.any? ? dd[1].inner_html.to_i : nil),
      })
      
      Rails.logger.debug tr.search(".ability_icon")[0].attributes["src"]
      puts tr.search(".ability_icon")[0].attributes["src"]
      iconURL = "http://na.leagueoflegends.com" + tr.search(".ability_icon")[0].attributes["src"]
      
      if FileTest.exists?("app/assets/images/skills/" + self.name + "_" + s.name.titleize.sub(" ", "_") + ".png") == false
        open("app/assets/images/skills/" + self.name + "_" + s.name.titleize.sub(" ", "_") + ".png", 'wb') do |file|
          file << open( iconURL ).read
        end
        s.url = "/assets/skills/" + self.name + "_" + s.name.titleize.sub(" ", "_") + ".png"
        s.save
        sleep 1
      end
      
      self.skills << s
      
    end

    
  end
  
end
