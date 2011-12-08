desc "This task is called by the Heroku scheduler add-on"

task :update_caches => :environment do
  
  oldCounterpickCache = CounterpickCache.find(1)
  if oldCounterpickCache.updated_at.utc >= 24.hours.ago.utc
    oldCounterpickCache.updateCounterpickCache
  end
  
end







  
  # oldWikiaCache = WikiaCache.find(1)
  # if oldWikiaCache.updated_at.utc <= 24.hours.ago.utc
  #   oldWikiaCache.updateWikiaCache
  # end
  
  
  
  
  