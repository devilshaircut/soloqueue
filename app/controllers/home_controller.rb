class HomeController < ApplicationController
  
  def index
    response.headers['Cache-Control'] = 'public, max-age=3600' if Rails.env.production?
  end

  def about 
  end
end





