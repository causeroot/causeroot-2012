class Titles4all < ActiveRecord::Migration
  def up
    add_column :issues, :title, :string
    add_column :causes, :title, :string
    add_column :effects, :title, :string
  end

  def down
    remove_column :issues, :title
    remove_column :causes, :title
    remove_column :effects, :title
  end
end
