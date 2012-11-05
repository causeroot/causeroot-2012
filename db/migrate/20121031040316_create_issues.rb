class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :problem
      t.text :cause
      t.text :effects

      t.timestamps
    end
  end
end
