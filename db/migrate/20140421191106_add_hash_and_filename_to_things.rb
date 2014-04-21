class AddHashAndFilenameToThings < ActiveRecord::Migration
  def change
    add_column :things, :hash, :string
    add_column :things, :filename, :string
  end
end
