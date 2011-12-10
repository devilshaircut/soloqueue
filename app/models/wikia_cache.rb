class WikiPages
  include HTTParty
  format :xml
end

class WikiaCache < ActiveRecord::Base
  

  # Obtain a list of champions from Wikia and create rows in the DB for champs that aren't there yet.
  def self.seedChampList
    
    # Isolate the champ names (wrapper in anchors).
    champPage = Hpricot(HTTParty.get("http://leagueoflegends.wikia.com/wiki/List_of_champions")).search("table.sortable a.mw-redirect")
    
    # Remove HTML element's attributes.
    champPage = champPage.search("[@class]").each do |e|
      e.remove_attribute("class")
      e.remove_attribute("title")
      e.remove_attribute("href")
    end
    
    # Use HTML to identify each champ, remove the HTML, and shove the champs into a sorted array.
    champPage = champPage.to_s.gsub("</a><a>", "|").gsub("<a>", "").gsub("</a>", "").split("|").sort! { |a,b| a <=> b }
    
    # Format each champ's name in a more code-friendly format.
    champPage = champPage.collect do |u|
      u.gsub(" ",'_')
    end
    
    # Find or shove each champ into the DB.
    champPage.each do |s|
      WikiaCache.find_or_create_by_wikianame(:wikianame => s)
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
    itemPage = itemPage.to_s.gsub("</span><span>", "|").gsub("<span>", "").gsub("</span>", "").split("|").sort! { |a,b| a <=> b }
    
    # Format each item's name in a more code-friendly format.
    itemPage = itemPage.collect do |u|
      u.gsub(" ",'_')
    end

    # Find or shove each champ into the DB.
    itemPage.each do |s|
      WikiaCache.find_or_create_by_wikianame(:wikianame => s)
    end
    
  end
  
  # Seed the the WikiaCache table's latestwikia column with new data.
  def self.updateLatestWikia
    WikiaCache.all.each do |u|
      champName = ERB::Util.url_encode(u.wikianame.to_s)
      baseUrl = "http://leagueoflegends.wikia.com/wiki/"
      u.latestwikia = HTTParty.get(baseUrl + champName).to_json
      u.save
    end
  end
  
  def self.getLatestWikia(query)
    entry = WikiaCache.find_by_wikianame(query).latestwikia
    return entry
  end
  
end











