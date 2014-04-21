class ChangeThingsKeytoFileKey < ActiveRecord::Migration
  def change
    rename_column :things, :key, :filekey
  end
end
