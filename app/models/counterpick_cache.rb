class Counterpicks
  include HTTParty
  format :xml  
end

class CounterpickCache < ActiveRecord::Base
  
  attr_accessor :latestcounterpick
    
  # Get a the list of champs from the Google Spreadsheet API, then update the cache.
  def updateCounterpickCache
    CounterpickCache.find(1).latestcounterpick = Counterpicks.get('https://spreadsheets.google.com/feeds/list/0AvFI-VeUB6LddEtiY3RqQUg2eGlLMEpMN2llN0dsVGc/od6/public/values').as_json['feed']['entry']
  end
  
end



