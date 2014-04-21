class ChangeThingsHashToKey < ActiveRecord::Migration
  def change
    rename_column :things, :hash, :key
  end
end
