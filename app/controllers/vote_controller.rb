class VoteController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    unless current_user.present? && params[:champ].present?
      head :bad_request 
      return
    end
    
    champ = Champion.find_by_name(params[:champ])    
    current_user.votes.where( :champion_id => champ.id ).delete_all
    
    params[:vote].each do |k,v|
      counterpick = Champion.find_by_id( v[:name].to_i )
      reason = Reason.find_by_id( v[:reason].to_i )
      if counterpick.present?
        if reason.present?
          Vote.create( :user_id => current_user.id, :champion_id => champ.id, :counterpick_id => counterpick.id, :reason_id => reason.id  )
        else
          Vote.create( :user_id => current_user.id, :champion_id => champ.id, :counterpick_id => counterpick.id )
        end
      end
    end
    
    respond_to do |format|
      format.html
      format.json{ head :ok }
    end
    
  end
  
end
