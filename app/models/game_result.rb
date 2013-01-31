# Game 
class GameResult < ActiveRecord::Base
  attr_accessible :question, :question_id, :user, :issues, :answer, :same, :skip
  belongs_to :user
  belongs_to :question
  has_and_belongs_to_many :issues, :join_table => "game_results_issues", :autosave => true
  after_initialize :default_values
  
  private
    def default_values
      self.skip = false if (self.has_attribute? :skip) && self.skip.nil?
      self.same = false if (self.has_attribute? :same) && self.same.nil?
    end

end
