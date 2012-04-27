class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :title
      t.text :description
      t.string :award
      t.datetime :deadline
      t.datetime :post_date
      t.string :image
      t.string :url_reference
      t.string :discussion_board

      t.timestamps
    end
  end
end
