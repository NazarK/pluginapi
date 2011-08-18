class AddNickToProfiles < ActiveRecord::Migration
  def self.up
    add_column :profiles, :nick, :string
  end

  def self.down
    remove_column :profiles, :nick
  end
end
