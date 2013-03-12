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


  def self.pick_result(uId)
    @game_result = GameResult.new
    question_randomizing_prob = 0.70
    problem_randomizing_prob = 0.70
    epsilon = 0.00000001

    played_games = GameResult.select{|g| g.user_id == uId && g.skip == false}
    #played_games = GameResult.select{|g| g.user_id == uId && g.skip == false}

    if rand() < question_randomizing_prob && played_games != nil
      question_list = Question.all.map{|q| q.id}
      next_question_id = question_list.sort_by{|q| played_games.select{|g| g.question_id == q}.count}.first
    else
      question_list = Question.all.map{|q| q.id}
      next_question_id = question_list[rand(question_list.size)]
    end
    # TODO: This needs to be modified at some point to not only ask a single question excessively/heavily when a new one is added to the mix
    @game_result.question = Question.offset(next_question_id-1).first

    game_info_for_single_question = played_games.select{|pg| pg.question_id == next_question_id}
    problem_pairs = game_info_for_single_question.map{|pg| pg.issue_ids.sort}.uniq.sort

    game_results_with_flags = FlaggedIssues.select{|f| f.issue_id > 0}
    remove_flags = []
    game_results_with_flags.select{|grwf| GameResult.find{|g| g.user_id == uId && g.id == grwf.game_result_id }}.each do |gr|
      remove_flags << gr.issue_id
    end

    remove_same = played_games.select{|g| g.same }.map{|q| q.issue_ids-[q.answer]}.flatten

    #Probs is all of the problems that we could potentially ask the user
    probs = Issue.all.map{|r| r.id} - remove_flags - remove_same

    probs_focus = probs.sort_by{|p| -problem_pairs.flatten.count(p)}[0..14]
    probs_left = probs - probs_focus

    #TODO: FIX this code to accommodate more than 2 problems
    choice = rand()+epsilon

    if choice < problem_randomizing_prob || probs_left == [] || probs_left == nil
      problem_choices = probs_focus.combination(2).to_a.map{|a| a.sort}-problem_pairs
      if problem_choices == []
        remove_same_flag_problems = probs_focus.combination(2).to_a.map{|a| a.sort}
        next_issues = remove_same_flag_problems[rand(remove_same_flag_problems.length)]
      else
        next_issues = problem_choices[rand(problem_choices.length)]
      end
    else
      problem_choices = probs_left.combination(2).to_a.map{|a| a.sort}-problem_pairs
      if problem_choices == []
        remove_same_flag_problems = probs_focus.combination(2).to_a.map{|a| a.sort}
        next_issues = remove_same_flag_problems[rand(remove_same_flag_problems.length)]
      else
        next_issues = problem_choices[rand(problem_choices.length)]
      end
    end

    #puts next_issues
    a = next_issues[0]-1
    b = next_issues[1]-1

    if rand(2).to_i == 1
      @game_result.issues << Issue.offset(a).first
      @game_result.issues << Issue.offset(b).first
    else
      @game_result.issues << Issue.offset(b).first
      @game_result.issues << Issue.offset(a).first
    end

    return @game_result
  end
end
