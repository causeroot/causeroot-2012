class CreateEffects < ActiveRecord::Migration
  def change
    create_table :effects do |t|
      t.text :effect
      t.integer :issue_id
      t.timestamps
    end
  end
end
