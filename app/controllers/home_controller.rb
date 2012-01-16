class HomeController < ApplicationController
  
  def index
    response.headers['Cache-Control'] = 'public, max-age=3600' if Rails.env.production?
    
    
    @all_champs = Champion.all.map{ |c| [ c.name, c.id ]}
    @all_reasons = Reason.all.map{ |r| [r.title, r.id ] }
  end

  def about 
  end
end





