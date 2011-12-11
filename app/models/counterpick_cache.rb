class CounterpickCache < ActiveRecord::Base
    
  # Get a the list of champs from the Google Spreadsheet API, then update the cache.
  def self.updateCounterpickCache
    counterpicks = CounterpickCache.find_or_create_by_id(1)
    counterpicks.latestcounterpick = HTTParty.get('https://spreadsheets.google.com/feeds/list/0AvFI-VeUB6LddEtiY3RqQUg2eGlLMEpMN2llN0dsVGc/od6/public/values', {:format => :xml}).to_json
    counterpicks.save
    output = JSON.parse(counterpicks.latestcounterpick)
  end
  
end



