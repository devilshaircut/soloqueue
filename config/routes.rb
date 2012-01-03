Soloqueue::Application.routes.draw do
  
  root :to    => "home#index"
  
  get "about" => "home#about"
  get "damage-calculator" => "home#damage_calculator"
  get "masteries" => "home#masteries"
    
  get "/api/:input_name.json" => "api#fetch_data"
  
end
