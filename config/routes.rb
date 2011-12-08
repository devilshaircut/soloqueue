Soloqueue::Application.routes.draw do
  
  root :to    => "home#index"
  
  get "test"  => "home#test"
  get "jason" => "home#for_jason"
  
  get "/champion/:champion_name" => "home#findCounters"
end
