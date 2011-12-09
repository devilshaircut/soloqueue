class ForJasonController < ApplicationController
  
  include HTTParty

  def for_jason
    
    # Given a champion name, return his or her skills from Wikia.
    def findSkills(champion)
      
      # Construct the URL from params and make the page request.
      url = "http://leagueoflegends.wikia.com/wiki/"
      champ = champion.to_s
      wikiaList = HTTParty.get(url << champ)
      
      # Extract the abilities table from the page.
      skills = Hpricot(wikiaList).search(".abilities_table")
      
      # Remove inline styles.
      skills.search("[@style]").each do |e|
        e.remove_attribute("style")
      end
      
      return skills.to_html
      
    end
    
    # Run the findSkills method.
    @jason = findSkills(params["champions"])
    
  end
  
end






