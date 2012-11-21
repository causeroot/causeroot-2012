class CreateCauses < ActiveRecord::Migration
  def change
    create_table :causes do |t|
      t.text :cause
      t.integer :issue_id
      t.timestamps
    end
  end
end
