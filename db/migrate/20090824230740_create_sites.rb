class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.string      :name
      t.string      :url
      
      t.integer     :meetup_group_id

      t.timestamps
    end
    
    add_index :sites, :url
  end

  def self.down
    drop_table :sites
  end
end
