class ApiController < ApplicationController
  
  def fetch_data
    champion_name = params[:champion_name]
    
    counters      = fetch_counters(champion_name)
    general_data  = fetch_general_data(champion_name)
    
    response.headers['Cache-Control'] = 'public, max-age=3600' if Rails.env.production?
    render :json => { :counters => counters, :wiki => general_data }
  end
  
  protected
  
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
    
    infodoc = strip_a( Hpricot(w.latestwikia).search("table.infobox table") )
    abilitiesdoc = strip_a( Hpricot(w.latestwikia).search("table.abilities_table") )

    w_out = ''
    w_out += infodoc.to_html    
    w_out += abilitiesdoc.to_html
    
    return w_out
  end
  
  def strip_a(doc)
    doc.search("a[@href]") do |link|
      text = link.inner_html
      link.swap(text)
    end
  end
  
end