class Champion < ActiveRecord::Base
  has_many :votes
  has_many :counterpicks, :through => :votes, :source => :counterpick
  # ^^^ this relationship means you can do Champion.find(1).counterpicks  and it will return all champs voted as counterpicks.
end
