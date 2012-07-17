class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.string :name
      t.string :type
      t.string :xpath
      t.string :regex
      t.string :field_name
      t.integer :url_id
      t.integer :rule_id

      t.timestamps
    end
  end
end
