class HomeController < ApplicationController
  
  def index
    
    # Google Spreadsheet API request. Isolates the list of champs.
    @entriesList = HTTParty.get('https://spreadsheets.google.com/feeds/list/0AvFI-VeUB6LddEtiY3RqQUg2eGlLMEpMN2llN0dsVGc/od6/public/values', {:format => :xml}).as_json['feed']['entry']
    Rails.logger.debug
    
    # Given a champion, find his or her counters.
    def findCounters(champion)
      memo = 1
      if champion == nil
        return "Welcome to the LoL Counter Picker!"
      else
        until memo == @entriesList.count || champion == @entriesList[memo]["title"]
          memo += 1
        end
        if memo == @entriesList.count
          return "ERROR."
        else
          return [@entriesList[memo]["_cokwr"], @entriesList[memo]["_cpzh4"], @entriesList[memo]["_cre1l"]]
        end
      end
    end
    
    # Pass a champion to findCounters.
    @request = findCounters(params["champions"])
    
  end

  def for_jason
    cc = CounterpickCache.find_or_create_by_id(1)
    cc.latestcounterpick = HTTParty.get('https://spreadsheets.google.com/feeds/list/0AvFI-VeUB6LddEtiY3RqQUg2eGlLMEpMN2llN0dsVGc/od6/public/values', {:format => :xml}).to_json
    cc.save
    
    output = JSON.parse( cc.latestcounterpick )
    
    Rails.logger.debug output["feed"]["entry"]

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





