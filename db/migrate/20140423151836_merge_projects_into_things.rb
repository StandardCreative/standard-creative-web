class MergeProjectsIntoThings < ActiveRecord::Migration
  def change
    drop_table :projects

    add_reference :things, :user
    add_column :things, :body, :text
  end
end
