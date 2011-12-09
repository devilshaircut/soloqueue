desc "This task is called by the Heroku scheduler add-on"
task :update_caches => :environment do
  
  if CounterpickCache.count != 0 && CounterpickCache.find(1).latestcounterpick != nil
    oldCounterpickCache = CounterpickCache.find(1)
  else
    CounterpickCache.create
    oldCounterpickCache = CounterpickCache.find(1)
    oldCounterpickCache.updateCounterpickCache
  end

  if oldCounterpickCache.updated_at.utc >= 24.hours.ago.utc
    oldCounterpickCache.updateCounterpickCache
  end
  
end







  
  # oldWikiaCache = WikiaCache.find(1)
  # if oldWikiaCache.updated_at.utc <= 24.hours.ago.utc
  #   oldWikiaCache.updateWikiaCache
  # end
  
  
  
  
  