desc "Manually initiate this task to update the database or build it to a an original state."

task :update_wikia_table => :environment do
  WikiaCache.seedChampList
  WikiaCache.seedItemList
  WikiaCache.updateLatestWikia
end









