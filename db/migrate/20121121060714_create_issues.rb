class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.text :problem

      t.timestamps
    end
  end
end
