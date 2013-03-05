# Issue
class Issue < ActiveRecord::Base
  attr_accessible :title, :problem, :causes, :effects, :causes_attributes, :effects_attributes
  acts_as_taggable

  validates :problem, :presence => true
  validates_uniqueness_of :problem, :scope => :user_id
  has_many :causes
  has_many :effects
  accepts_nested_attributes_for :causes, :allow_destroy => true
  accepts_nested_attributes_for :effects, :allow_destroy => true
  has_and_belongs_to_many :game_result
  belongs_to :user
end
