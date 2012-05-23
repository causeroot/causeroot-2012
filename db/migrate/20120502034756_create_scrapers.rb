class CreateScrapers < ActiveRecord::Migration
  def change
    create_table :scrapers do |t|
      t.string :name
      t.string :url
      t.string :title_xpath
      t.text :description_xpath
      t.string :award_xpath
      t.datetime :deadline_xpath
      t.datetime :post_date_xpath
      t.string :image_xpath
      t.text :rules_xpath
		
      t.timestamps
    end
  end
end
