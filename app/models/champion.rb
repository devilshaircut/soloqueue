class Champion < ActiveRecord::Base
  has_many :votes
end