class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :name
      t.string :question
      t.integer :problem_count

      t.timestamps
    end
  end
end
