class AddCounterpickIdToVote < ActiveRecord::Migration
  def change
    add_column :votes, :counterpick_id, :integer
  end
end
