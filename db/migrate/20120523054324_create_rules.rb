class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.string :type
      t.string :xpath
      t.string :regex
      t.string :token
      t.string :modifier
      t.string :field

      t.integer :scraper_id
    end
    
  end
end
