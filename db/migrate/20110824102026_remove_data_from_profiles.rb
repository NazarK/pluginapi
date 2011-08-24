class RemoveDataFromProfiles < ActiveRecord::Migration
  def self.up
    remove_column :profiles, :data
  end

  def self.down
  end
end
