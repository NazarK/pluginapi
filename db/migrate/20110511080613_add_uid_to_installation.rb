class AddUidToInstallation < ActiveRecord::Migration
  def self.up
    add_column :installations, :uid, :string
    add_index :installations, :uid,  {:unique => true}
  end

  def self.down
    remove_column :installations, :uid
  end
end
