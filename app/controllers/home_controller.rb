class HomeController < ApplicationController
  
  def index    
    @all_champs = Champion.all.map{ |c| [ c.name, c.id ]}
    @all_reasons = Reason.all.map{ |r| [r.title, r.id ] }
  end

  def about 
  end
end





