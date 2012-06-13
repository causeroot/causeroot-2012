class CreateScrapers < ActiveRecord::Migration
  def change
    create_table :scrapers do |t|
      t.string :name
      t.string :url_regex
      t.integer :rule_id

      t.timestamps
    end
  end
end
