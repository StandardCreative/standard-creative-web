class AddUrlAndUrlKeyToThings < ActiveRecord::Migration
  def change
    add_column :things, :url, :string
    add_column :things, :url_key, :string

    add_index :things, :url
    add_index :things, :url_key, unique: true

    Thing.initialize_urls

    Thing.where("url_key is null").each do |thing|
        thing.generate_url_key
        thing.save!
    end
  end
end
