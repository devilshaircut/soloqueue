class ForJasonController < ApplicationController
  
  include HTTParty

  def for_jason
    
    def findSkills(champion)
      url = "http://leagueoflegends.wikia.com/wiki/"
      champ = champion.to_s
      wikiaList = HTTParty.get(url << champ)
      return Hpricot(wikiaList).search(".abilities_table").to_html
    end
    
    @jason = findSkills(params["champions"])
    
  end
  
end






