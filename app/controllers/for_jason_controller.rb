class ForJasonController < ApplicationController
  
  include HTTParty

  def for_jason
    
    # Given a champion name, return his or her skills from Wikia.
    def findSkills(champion)
      
      # Construct the URL from params and make the page request.
      url = "http://leagueoflegends.wikia.com/wiki/"
      champ = champion.to_s.gsub(/[ .']/,'').downcase
      wikiaList = HTTParty.get(url << champ)
      
      # Extract the abilities table from the page.
      skills = Hpricot(wikiaList).search(".abilities_table")
      
      # Remove inline styles.
      skills.search("[@style]").each do |e|
        e.remove_attribute("style")
      end
      
      return skills.to_html
      
    end
    
    # Obtain a list of items from Wikia.
    def getItemList
      
      # Isolate the item names (wrapped in spans).
      itemPage = Hpricot(HTTParty.get("http://leagueoflegends.wikia.com/wiki/Category:Items")).search("table.navbox td a span")
      
      # Remove HTML element's attributes.
      itemPage.search("[@class]").each do |e|
        e.remove_attribute("class")
      end
      
      # Use HTML to identify each item, remove the HTML, and shove the items into a sorted array.
      itemPage = itemPage.to_s.gsub("</span><span>", "|").gsub("<span>", "").gsub("</span>", "").split("|").sort! { |a,b| a <=> b }
      
      # Format list as HTML.
      return itemPage
      
    end
    
    # Obtain a list of champions from Wikia.
    def getChampList
      
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
      
      # Format list as HTML.
      return champPage
      
    end
    
    # Give the view the item and champ lists.
    @itemList = self.getItemList
    @champList = self.getChampList
    
    # # Create a version of the item list which is totally unformatted.
    # @unformattedItemList = @itemList.collect do |u|
    #   u.gsub(" ",'').gsub(".",'').gsub("'",'').downcase
    # end
    
    # Create a version of the item list formatted for requesting the correct item page.
    @unformattedItemList = @itemList.collect do |u|
      u.gsub(" ",'_')
    end
    
    # Create a version of the champ list formatted for requesting the correct champ page.
    @unformattedChampList = @champList.collect do |u|
      u.gsub(" ",'_')
    end
    
    # Run the findSkills method with user input.
    @jason = findSkills(params["champions"])
    
  end
  
end






