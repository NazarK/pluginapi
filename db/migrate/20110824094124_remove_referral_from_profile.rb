class RemoveReferralFromProfile < ActiveRecord::Migration
  def self.up
    remove_column :profiles, :referral_id
  end

  def self.down
  end
end
