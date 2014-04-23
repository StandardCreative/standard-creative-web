class DropProjectIdFromThings < ActiveRecord::Migration
  def change
    remove_reference :things, :project
  end
end
