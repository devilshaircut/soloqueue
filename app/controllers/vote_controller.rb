class VoteController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    champ = Champion.find params[:champion_id]
    Vote.create( :champion_id => champ, :user_id => current_user.id )
  end
  
end
