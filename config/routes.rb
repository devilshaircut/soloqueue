Soloqueue::Application.routes.draw do
  
  root :to    => "home#index"
  
  get "test"  => "home#test"
  
  get "/champion/:champion_name.json" => "api#fetch_data"
  
end
