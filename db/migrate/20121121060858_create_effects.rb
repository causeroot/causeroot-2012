class CreateEffects < ActiveRecord::Migration
  def change
    create_table :effects do |t|
      t.integer :issue_id
      t.text :effect
      t.timestamps
    end
  end
end
