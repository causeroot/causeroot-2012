class CreateSameIssues < ActiveRecord::Migration
  def change
    create_table :same_issues do |t|
      t.references :game_result
      t.references :issue
      t.timestamps
    end
  end
end
