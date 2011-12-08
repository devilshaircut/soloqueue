Soloqueue::Application.routes.draw do
  
  root :to    => "home#index"
  
  get "test"  => "home#test"
  match "jason" => "for_jason#for_jason"
  
  get "/champion/:champion_name" => "home#findCounters"
end
