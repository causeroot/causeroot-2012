class AddXpath < ActiveRecord::Migration
  def up
    add_column :challenges, :xpath, :string, :default => nil
  end

  def down
    remove_column :challenges, :xpath
  end
end
