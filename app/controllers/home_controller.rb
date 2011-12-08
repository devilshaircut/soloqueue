class HomeController < ApplicationController
  
  def index
  end

  def findCounters
    entriesList = HTTParty.get('https://spreadsheets.google.com/feeds/list/0AvFI-VeUB6LddEtiY3RqQUg2eGlLMEpMN2llN0dsVGc/od6/public/values', {:format => :xml}).as_json['feed']['entry']
        
    counters = nil
        
    entriesList.each do | entry |
      if entry["title"].downcase == params[:champion_name].downcase
        if entry["_cokwr"] == nil
          a = "n/a"
        else
          a = entry["_cokwr"]
        end
        if entry["_cpzh4"] == nil
          b = "n/a"
        else
          b = entry["_cpzh4"]
        end
        if entry["_cre1l"] == nil
          c = "n/a"
        else
          c = entry["_cre1l"]
        end
        counters = [
          a,
          b,
          c
        ] 
      end
    end
        
    response = ( counters.nil? ? nil : counters )

    render :json => { :counters => response }
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





