class RemoveOrgIdFromProfile < ActiveRecord::Migration
  def self.up
    remove_column :profiles, :org_id
  end

  def self.down
  end
end
