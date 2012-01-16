class AddReasonIdToVote < ActiveRecord::Migration
  def change
    add_column :votes, :reason_id, :integer
  end
end
