class RenameInstallationsProfiles < ActiveRecord::Migration
  def self.up
    rename_table :installations, :profiles
  end

  def self.down
    rename_table :profiles, :installations
  end
end
