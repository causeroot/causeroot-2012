class CreateGameResults < ActiveRecord::Migration
  def change
    create_table :game_results do |t|
      t.integer :user_id
      t.integer :question_id
      t.integer :answer
      t.boolean :same
      t.boolean :skip

      t.timestamps
    end
    
    create_table :game_results_issues do |t|
    	t.integer :issue_id
    	t.integer :game_result_id
    end
  end
end
