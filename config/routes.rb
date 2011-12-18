Soloqueue::Application.routes.draw do
  
  root :to    => "home#index"
  
  get "about" => "home#about"
  get "test" => "home#test"
    
  get "/api/:input_name.json" => "api#fetch_data"
  
end
