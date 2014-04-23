class AddFeaturedToThings < ActiveRecord::Migration
  def change
    add_column :things, :featured, :bool
  end
end
