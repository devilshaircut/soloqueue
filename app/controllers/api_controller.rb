class ApiController < ApplicationController
  
  def fetch_data
    champion_name = params[:champion_name]
    
    counters      = fetch_counters(champion_name)
    general_data  = fetch_general_data(champion_name)
    
    response.headers['Cache-Control'] = 'public, max-age=3600' if Rails.env.production?
    render :json => { :counters => counters, :wiki => general_data }
  end
  
  def fetch_counters(champion_name)
    cc = CounterpickCache.find_or_create_by_id(1)
    cc.updateCounterpickCache if cc.latestcounterpick.nil?
    tmp = JSON.parse(cc.latestcounterpick)
    entriesList = tmp["feed"]["entry"]
    
    counters = nil  
    
    entriesList.each do | entry |
      if entry["title"].downcase == champion_name.downcase
        counters = [
          ( entry["_cokwr"].nil? ? "n/a" : entry["_cokwr"] ),
          ( entry["_cpzh4"].nil? ? "n/a" : entry["_cpzh4"] ),
          ( entry["_cre1l"].nil? ? "n/a" : entry["_cre1l"] )
        ]
      end
    end
    
    return counters
  end
  
  def fetch_general_data(champion_name)
    w = WikiaCache.find_by_wikianame(champion_name)

    w_out = ''
    w_out += Hpricot(w.latestwikia).search("table.infobox table").to_html    
    w_out += Hpricot(w.latestwikia).search("table.abilities_table").to_html
    
    return w_out
  end
end