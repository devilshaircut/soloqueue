Soloqueue::Application.routes.draw do
  
  devise_for :users do
    get "login" => "devise/sessions#new"
    get "logout" => "devise/sessions#destroy"
  end

  root :to    => "home#index"
  

    
  get "about" => "home#about"
  get "damage-calculator" => "home#damage_calculator"
  get "masteries" => "home#masteries"
    
  get "/api/:input_name.json" => "api#fetch_data"
  
  resources :vote
end
