class CounterpickCache < ActiveRecord::Base
    
  # Get a the list of champs from the Google Spreadsheet API, then update the cache.
  def updateCounterpickCache
    self.latestcounterpick = HTTParty.get('https://spreadsheets.google.com/feeds/list/0AvFI-VeUB6LddEtiY3RqQUg2eGlLMEpMN2llN0dsVGc/od6/public/values').xml_in.as_json['feed']['entry']
    self.save
  end
  
end



