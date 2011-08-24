class AddParentToProfile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :parent_id, :integer
  end

  def self.down
    remove_column :profiles, :parent_id
  end
end
