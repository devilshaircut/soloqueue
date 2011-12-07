class Entries
  include HTTParty
  format :xml  
end

class HomeController < ApplicationController
  
  def index
    
    # Google Spreadsheet API request. Isolates the list of champs.
    @entriesList = Entries.get('https://spreadsheets.google.com/feeds/list/0AvFI-VeUB6LddEtiY3RqQUg2eGlLMEpMN2llN0dsVGc/od6/public/values').as_json['feed']['entry']
    
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

end





