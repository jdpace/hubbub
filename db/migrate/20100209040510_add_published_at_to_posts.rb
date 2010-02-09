class AddPublishedAtToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :published_at, :datetime
    add_index  :posts, :published_at
  end

  def self.down
    remove_index :posts, :published_at
    remove_column :posts, :published_at
  end
end
