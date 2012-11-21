class CreateGameData < ActiveRecord::Migration
  def change
    create_table :game_data do |t|
      t.integer :user_id
      t.integer :question_id
      t.integer :response_id
      t.timestamps
    end
    create_table :game_data_issues do |t|
        t.integer :issue_id
        t.integer :game_data_id 
    end
  end
end
