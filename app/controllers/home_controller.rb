class HomeController < ApplicationController
  
  def index
  end
  
  def test
    tmp = HTTParty.get("http://leagueoflegends.wikia.com/api.php",{
      :query => {
        :action=>:query,
        :titles=>"Akali the Fist of Shadow",
        :prop=>:revisions,
        :rvprop=>:content,
        :format=>:json
      }
    })
    Rails.logger.debug tmp.body
    json = JSON.parse(tmp.body)
    @output = json["query"]["pages"]["4994"]["revisions"][0]["*"]
    tmp1 = HTTParty.post("http://leagueoflegends.wikia.com/api.php", {
      :query => {
        :action => :parse,
        :text => @output
      }
    })
    @output2 = tmp1.body
    # @output1 = JSON.parse(tmp1.body)
    # Rails.logger.debug @output1.inspect
  end

end





