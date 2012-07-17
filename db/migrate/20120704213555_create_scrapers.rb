class CreateScrapers < ActiveRecord::Migration
  def change
    create_table :scrapers do |t|
      t.string :name
      t.integer :url_id
      t.integer :site_id
      t.integer :rule_id

      t.timestamps
    end
  end
end
