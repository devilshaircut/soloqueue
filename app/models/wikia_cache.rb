class WikiPages
  include HTTParty
  format :xml
end

class WikiaCache < ActiveRecord::Base

  # Obtain a list of champions from Wikia and create rows in the DB for champs that aren't there yet.
  def seedChampList
    
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
  
end



