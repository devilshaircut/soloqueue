class VoteController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    unless current_user.present? && params[:champ].present?
      head :bad_request 
      return
    end
    
    Rails.logger.debug params.inspect
    # champ = Champion.find params[:champion_id]
    # Vote.create( :champion_id => champ, :user_id => current_user.id )

    champ = Champion.find_by_name(params[:champ])    
    current_user.votes.where( :champion_id=>champ.id ).delete_all
    
    params[:vote].each do |k,v|
      Vote.create( :user_id => current_user.id, :champion_id => champ.id, :counterpick_id => v[:name], :reason_id => v[:reason]  )
    end
    
    respond_to do |format|
      format.html
      format.json{ head :ok }
    end
    
  end
  
end
