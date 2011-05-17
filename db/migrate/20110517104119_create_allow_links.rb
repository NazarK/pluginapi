class CreateAllowLinks < ActiveRecord::Migration
  def self.up
    create_table :allow_links do |t|
      t.string :link

      t.timestamps
    end
  end

  def self.down
    drop_table :allow_links
  end
end
