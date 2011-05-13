class FixInstallationId < ActiveRecord::Migration
  def self.up
    rename_column :plugin_data_posts, :installation_id, :profile_id
  end

  def self.down
  end
end
