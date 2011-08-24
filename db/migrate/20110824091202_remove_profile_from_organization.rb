class RemoveProfileFromOrganization < ActiveRecord::Migration
  def self.up
    remove_column :organizations, :profile_id
  end

  def self.down
    add_column :organizations, :profile_id, :integer
  end
end
