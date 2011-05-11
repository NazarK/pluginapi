class AddOrgIdToInstallation < ActiveRecord::Migration
  def self.up
    add_column :installations, :org_id, :string
  end

  def self.down
    remove_column :installations, :org_id
  end
end
