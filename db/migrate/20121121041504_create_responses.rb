class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :answer
      t.boolean :same
      t.boolean :skip
        
      t.timestamps
    end
  end
end
