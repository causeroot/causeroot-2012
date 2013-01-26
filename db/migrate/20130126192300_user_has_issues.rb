class UserHasIssues < ActiveRecord::Migration
  def up
    add_column :issues, :user_id, :integer 
  end

  def down
    remove_column :issues, :user_id
  end
end
