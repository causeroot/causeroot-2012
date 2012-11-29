class CreateCauses < ActiveRecord::Migration
  def change
    create_table :causes do |t|
      t.integer :issue_id
      t.text :cause
      t.timestamps
    end
  end
end
