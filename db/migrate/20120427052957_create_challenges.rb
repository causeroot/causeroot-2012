class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :title
      t.integer :url_id
      t.text :description
      t.string :award
      t.datetime :deadline
      t.datetime :post_date
      t.string :image
      t.text :rules

      t.timestamps
    end
  end
end
