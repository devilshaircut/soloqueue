Soloqueue::Application.routes.draw do
  
  root :to    => "home#index"
  
  get "about" => "home#about"
    
  get "/api/:input_name.json" => "api#fetch_data"
  
end
