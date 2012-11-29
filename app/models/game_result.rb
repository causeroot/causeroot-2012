# Game 
class GameResult < ActiveRecord::Base
  attr_accessible :question, :user, :issues, :answer, :same, :skip
  belongs_to :user
  belongs_to :question
  has_and_belongs_to_many :issues
end

