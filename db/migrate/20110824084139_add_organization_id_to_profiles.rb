class AddOrganizationIdToProfiles < ActiveRecord::Migration
  def self.up
    add_column :profiles, :organization_id, :integer
  end

  def self.down
    remove_column :profiles, :organization_id
  end
end
