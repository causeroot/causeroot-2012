class GameDatum < ActiveRecord::Base
  attr_accessible :question, :response, :user, :issues
  belongs_to :user
  has_one :question
  has_one :response
  has_many :issues, :through => :game_dataum_issues
  accepts_nested_attributes_for :response
end