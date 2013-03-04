class NoMoreTitles < ActiveRecord::Migration
  def up
    remove_column :issues, :title
    remove_column :causes, :title
    remove_column :effects, :title
  end

  def down
    add_column :issues, :title, :string
    add_column :causes, :title, :string
    add_column :effects, :title, :string
  end
end
