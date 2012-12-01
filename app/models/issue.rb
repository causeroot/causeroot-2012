# Issue
class Issue < ActiveRecord::Base
  attr_accessible :problem, :causes, :problems

  has_many :causes
  has_many :effects
  accepts_nested_attributes_for :causes
  accepts_nested_attributes_for :effects
  has_and_belongs_to_many :game_result
end
