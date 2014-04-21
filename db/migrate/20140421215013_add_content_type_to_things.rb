class AddContentTypeToThings < ActiveRecord::Migration
  def change
    add_column :things, :content_type, :string
  end
end
