class Response < ActiveRecord::Base
  attr_accessible :answer, :same, :skip
  belongs_to :game_datum

end
