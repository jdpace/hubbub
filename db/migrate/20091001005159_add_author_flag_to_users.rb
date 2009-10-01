class AddAuthorFlagToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :author, :boolean, :default => false
  end

  def self.down
    remove_column :users
  end
end
