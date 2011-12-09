class ApiController < ApplicationController
  def findCounters
    cc = CounterpickCache.find_or_create_by_id(1)
    cc.updateCounterpickCache if cc.latestcounterpick.nil?
    tmp = JSON.parse(cc.latestcounterpick)
    entriesList = tmp["feed"]["entry"]

    counters = nil
      
    entriesList.each do | entry |
      if entry["title"].downcase == params[:champion_name].downcase
        counters = [
          ( entry["_cokwr"].nil? ? "n/a" : entry["_cokwr"] ),
          ( entry["_cpzh4"].nil? ? "n/a" : entry["_cpzh4"] ),
          ( entry["_cre1l"].nil? ? "n/a" : entry["_cre1l"] )
        ]
      end
    end
      
    response = ( counters.nil? ? nil : counters )

    render :json => { :counters => response }
  end
end