class ApiController < ApplicationController
  
  def fetch_data
    
    if params[:input_name].nil?
      render :json => { :data => nil }
    else
      Search.create( :value=>params[:input_name], :ip=>request.remote_ip )
      input = params[:input_name].gsub("B F", "BF").gsub(" ", "_").gsub(/[.,'"-]/,"")
      item_names = fetch_names( input )

      data = []
      item_names.each do |item|
        counters      = fetch_counters(item[1])
        general_data  = fetch_general_data(item[0])
      
        data << [ item[1], :counters => counters, :wiki => general_data ]
      end
    
      response.headers['Cache-Control'] = 'public, max-age=3600' if Rails.env.production?
      render :json => { :data => data }
    end
  end
  
  protected
  
  def fetch_names( value )
    WikiaCache.where(["wikianame = ? or lower(wikianame) like '%#{value.downcase}%'", value]).collect{|x| [ x.wikianame, x.display_name ] }
  end
  
  def fetch_counters(champion_name)
    cc = CounterpickCache.find_or_create_by_id(1)
    cc.updateCounterpickCache if cc.latestcounterpick.nil?
    tmp = JSON.parse( cc.latestcounterpick )
    entriesList = tmp["feed"]["entry"]
    champ = Champion.find_by_name( champion_name )
    
    # curated counterpicks  
    counters = {}  
    curated = []
    entriesList.each do | entry |
      if entry["title"].downcase.strip == champion_name.downcase
        curated = [
          ( entry["_cokwr"].nil? ? "n/a" : entry["_cokwr"] ),
          ( entry["_cpzh4"].nil? ? "n/a" : entry["_cpzh4"] ),
          ( entry["_cre1l"].nil? ? "n/a" : entry["_cre1l"] )
        ]
      end
    end
    counters["curated"] = curated
    
    # community counterpicks
    community = []
    result = ActiveRecord::Base.connection.select_all( "select counterpick_id, count(*) as c from votes where champion_id=#{champ.id} group by counterpick_id order by c limit 3" )
    result.each do |r|
       c = Champion.find r["counterpick_id"]
       result2 = ActiveRecord::Base.connection.select_all( "select reason_id, count(*) as c from votes where champion_id=#{champ.id} and counterpick_id=#{c.id} group by reason_id order by c limit 3" )
       reasons = []
       result2.each do |r2|
         reasons << Reason.find(r2["reason_id"]).title
       end
       community << [c.name, reasons]
    end
    counters["community"] = community
    
    
    # logged in voting form
    counters["votes"] = {:logged_in => current_user.present?, :values=>nil }
    if current_user.present?
      counters["votes"]["values"] = current_user.votes.where( :champion_id=>champ.id ).select("counterpick_id, reason_id").all
    end
    
    return counters
  end
  
  def fetch_general_data(champion_name)
    w = WikiaCache.find_by_wikianame(champion_name)
    
    infodoc = strip_a( Hpricot(w.latestwikia).search("table.infobox table") )
    infodoc = strip_a( Hpricot(w.latestwikia).search("table.infobox") ) if infodoc.nil? or infodoc.empty? # its an item
    
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