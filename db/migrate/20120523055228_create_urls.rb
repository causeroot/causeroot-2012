class CreateUrls < ActiveRecord::Migration
  def change
		create_table :urls do |t|
			t.string :url
			t.string :rank	  
			t.timestamps
		end
	end
end
