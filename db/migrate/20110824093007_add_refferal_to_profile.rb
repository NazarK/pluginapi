class AddRefferalToProfile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :referral_id, :integer
  end

  def self.down
    remove_column :profiles, :referral_id
  end
end
