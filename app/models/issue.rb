class Issue < ActiveRecord::Base
  attr_accessible :problem
  has_many :causes
  has_many :effects
end
