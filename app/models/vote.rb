class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :champion
  belongs_to :counterpick, :class_name => "Champion", :foreign_key => "counterpick_id"
  belongs_to :reason
end
