class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :name
      t.string :url
      t.text :description
      t.string :award
      t.datetime :deadline
      t.datetime :post_date
      t.string :image_url
      t.text :rules

      t.timestamps
    end
  end
end
