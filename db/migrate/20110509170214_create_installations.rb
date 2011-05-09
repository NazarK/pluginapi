class CreateInstallations < ActiveRecord::Migration
  def self.up
    create_table :installations do |t|
      t.text :data

      t.timestamps
    end
  end

  def self.down
    drop_table :installations
  end
end
