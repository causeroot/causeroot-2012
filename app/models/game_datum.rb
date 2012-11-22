class GameDatum < ActiveRecord::Base
  attr_accessible :question, :response, :user, :issues
  belongs_to :user
  belongs_to :question
  belongs_to :response
  has_many :issues, :through => :game_dataum_issues
  accepts_nested_attributes_for :response
end
