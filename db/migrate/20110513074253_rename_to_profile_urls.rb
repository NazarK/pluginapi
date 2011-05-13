class RenameToProfileUrls < ActiveRecord::Migration
  def self.up
    rename_table :plugin_data_posts, :profile_urls
  end

  def self.down
  end
end
