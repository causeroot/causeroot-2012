# Question contains three fields
#		name is the short question name
#		question is the text of the full question
#		issue_count is the number of issues that should be presented to the user
#	Questions exist in the database to prevent hard coding them
class Question < ActiveRecord::Base
  attr_accessible :name, :question, :problem_count 
  validates_uniqueness_of :name
  validates_uniqueness_of :question
end
