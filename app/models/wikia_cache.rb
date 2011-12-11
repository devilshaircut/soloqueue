class WikiaCache < ActiveRecord::Base
  

  # Obtain a list of champions from Wikia and create rows in the DB for champs that aren't there yet.
  def self.seedChampList
    
    # Isolate the champ names (wrapper in anchors).
    champPage = Hpricot( HTTParty.get("http://leagueoflegends.wikia.com/wiki/List_of_champions") ).search("table.sortable a.mw-redirect")
    
    # Remove HTML element's attributes.
    champPage = champPage.search("[@class]").each do |e|
      e.remove_attribute("class")
      e.remove_attribute("title")
      e.remove_attribute("href")
    end
    
    # Use HTML to identify each champ, remove the HTML, and shove the champs into a sorted array.
    champPage = champPage.to_s.gsub("</a><a>", "|").gsub(/<[\/]*a>/, "").split("|").sort! { |a,b| a <=> b }
    
    # Find or shove each champ into the DB.
    champPage.each do |s|
      search_name =  s
      search_name = search_name.gsub("B._F.", "BF").gsub("B. F.", "BF").gsub(" ",'_').gsub(/[.,'"-]/,"")
      wc = WikiaCache.find_or_create_by_wikianame(:wikianame => search_name, :display_name => s)
    end
    
  end
  
  # Obtain a list of items from Wikia and create rows in the DB for champs that aren't there yet.
  def self.seedItemList
    
    # Isolate the item names (wrapped in spans).
    itemPage = Hpricot(HTTParty.get("http://leagueoflegends.wikia.com/wiki/Category:Items")).search("table.navbox td a span")
    
    # Remove HTML element's attributes.
    itemPage.search("[@class]").each do |e|
      e.remove_attribute("class")
    end
    
    # Use HTML to identify each item, remove the HTML, and shove the items into a sorted array.
    itemPage = itemPage.to_s.gsub("</span><span>", "|").gsub(/(<[\/]*span>)/, "").split("|").sort! { |a,b| a <=> b }
    
    # Find or shove each champ into the DB.
    itemPage.each do |s|
      search_name =  s
      search_name = search_name.gsub("B._F.", "BF").gsub("B. F.", "BF").gsub(" ",'_').gsub(/[.,'"-]/,"")
      wc = WikiaCache.find_or_create_by_wikianame(:wikianame => search_name, :display_name => s)
    end
    
  end
  
  # Seed the the WikiaCache table's latestwikia column with new data.
  def self.updateLatestWikia
    WikiaCache.all.each do |u|
      champName = ERB::Util.url_encode(u.display_name.to_s)
      baseUrl = "http://leagueoflegends.wikia.com/wiki/"
      u.latestwikia = HTTParty.get(baseUrl + champName).body
      u.save
    end
  end
  
  require 'open-uri'  
  
  # Scrape skill images from LoL Wikia.
  def self.seedSkillImages

    WikiaCache.all.each do |u|
            
      # Initialize strings which construct the URL to pull images from.
      champName = ERB::Util.url_encode(u.wikianame.to_s)
      baseUrl = "http://leagueoflegends.wikia.com/wiki/"      
      
      # Given a Wikia champ page, return the URLs of skill icon images in an array.
      iconUrlArray = Hpricot(HTTParty.get(baseUrl + champName).body).search("table.abilities_table .abilityname a img").collect { |i| i.attributes['src'] }
      
      # Given a Wikia champ page, return skill names in an array.
      iconNameArray = Hpricot(HTTParty.get(baseUrl + champName).body).search("table.abilities_table .abilityname b").collect { |i| i.inner_html }.collect { |q| q.strip.gsub(" ", "_").gsub(/':/, "") }
      
      memo = 0
      
      while memo < iconNameArray.count do
        
        iconURL = iconUrlArray[memo]
        iconName = iconNameArray[memo]
        
        # Given a Wikia champ page, save skill images into the project's assets library.
        open("app/assets/images/skills/" + champName + "_" + iconName + ".jpg", 'wb') do |file|
          file << open(iconURL).read
        end
        
        memo += 1
        
      end
    end
  end
  
  # Scrape champion images from LoL Wikia.
  def self.seedChampImages
    
    WikiaCache.all.each do |u|
            
      # Initialize strings which construct the URL to pull images from.
      champName = ERB::Util.url_encode(u.wikianame.to_s).gsub(" ",'_')
      champUrlName = ERB::Util.url_encode(u.display_name.to_s)
      baseUrl = "http://leagueoflegends.wikia.com/wiki/"
      
      # Given a Wikia champ page, return the URLs of champ icon images in an array.
      if Hpricot(HTTParty.get(baseUrl + champUrlName).body).search("table.infobox a.image img").to_a.count == 1
        iconChampArray = Hpricot(HTTParty.get(baseUrl + champUrlName).body).search("table.infobox a.image img").collect { |i| i.attributes['src'] }
      else
        iconChampArray = Hpricot(HTTParty.get(baseUrl + champUrlName).body).search("#WikiaArticle a.image img").collect { |i| i.attributes['src'] }
      end
      
      # Given a Wikia champ page, save champ images into the project's assets library.
      open("app/assets/images/champs/" + champName + ".jpg", 'wb') do |file|
        file << open(iconChampArray[0]).read
      end
      
    end
  end
  
  # Swap image URLs after a fresh scrape so that we are pulling images from our own data source.
  def self.updateCacheImages
    WikiaCache.all.each do |u|
      # Verify that this is a champion page, not a item page, before proceeding with the URL swap.
      if Hpricot(u.latestwikia).search("table.abilities_table").to_a.count == 1
        
        # Initialize strings which construct the old image URL to be changed.
        champName = ERB::Util.url_encode(u.wikianame.to_s).gsub(" ",'_')

        # Pull the HTML cache and create an array of skill names.
        iconNameArray = Hpricot(u.latestwikia).search("table.abilities_table .abilityname b").collect { |i| i.inner_html }.collect { |q| q.strip.gsub(" ", "_").gsub(/':/, "") }
      
        memo = 0
      
        # Loop through each skill for the champ and perform the swap.
        while memo < iconNameArray.count do
      
          iconName = iconNameArray[memo]
      
          # Obtains the old URL to be removed.
          oldUrl = Hpricot(u.latestwikia).search("table.abilities_table .abilityname a img")[memo]['src']
      
          # Obtains the new URL to be added.
          newUrl = "/assets/skills/" + champName + "_" + iconName + ".jpg"
      
          # Change perform the URL swap and save.
          u.latestwikia = Hpricot(u.latestwikia).to_html.gsub(oldUrl, newUrl)
          u.save
      
          memo += 1
        end
      end
      
      # Verify that this is a item page, not a champion page, before proceeding with the URL swap.
      if Hpricot(u.latestwikia).search("table.infobox tr img.thumbborder").count == 1
        # Initialize strings which construct the old image URL to be changed.
        itemName = u.wikianame
      
        # Obtains the old URL to be removed.
        oldUrl = Hpricot(u.latestwikia).search("table.infobox tr img.thumbborder")[0]['src']
      
        # Obtains the new URL to be added.
        newUrl = "/assets/champs/" + itemName + ".jpg"
      
        # Change perform the URL swap and save.
        u.latestwikia = Hpricot(u.latestwikia).to_html.gsub(oldUrl, newUrl)
        u.save
      end 
      
      # just fucking remove the inline image, its not really helpful and looks like shit
      if Hpricot(u.latestwikia).search("table.infobox tr td span img").count == 1
        oldUrl = Hpricot(u.latestwikia).search("table.infobox tr td span img")[0]
        u.latestwikia = Hpricot(u.latestwikia).to_html.sub(oldUrl.to_s, " ")
        u.save
      end 
    end
  end
  
end
