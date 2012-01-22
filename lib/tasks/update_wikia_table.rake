desc "Manually initiate this task to update the wikia database or build it to a an original state."
task :update_wikia_table => :environment do
  WikiaCache.updateLatestWikia
  WikiaCache.seedChampList
  WikiaCache.seedItemList
end

desc "Manually initiate this task to update the counterpick database or build it to a an original state."

task :update_counterpick_table => :environment do
  CounterpickCache.updateCounterpickCache
end

desc "Call the method that swaps image URLs after a fresh scrape so that we are pulling images from our own data source."
task :update_cache_images => :environment do
  WikiaCache.updateCacheImages
end


desc "Run all of the update tasks in order"
task :reseed => ['update_wikia_table', 'update_counterpick_table', 'update_cache_images']






