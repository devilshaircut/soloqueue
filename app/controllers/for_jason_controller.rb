class ForJasonController < ApplicationController
  
  include HTTParty

  def for_jason
    @jason = HTTParty.get("http://leagueoflegends.wikia.com/wiki/Akali_the_Fist_of_Shadow")
    @jason = Hpricot(@jason).search(".abilities_table").to_html
  end

  
  
end






