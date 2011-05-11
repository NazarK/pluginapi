class CreatePluginDataPosts < ActiveRecord::Migration
  def self.up
    create_table :plugin_data_posts do |t|
      t.integer :installation_id
      t.string :data

      t.timestamps
    end
  end

  def self.down
    drop_table :plugin_data_posts
  end
end
