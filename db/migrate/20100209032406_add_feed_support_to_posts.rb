class AddFeedSupportToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :feed_id,          :integer
    add_column :posts, :external_id,      :string
    add_column :posts, :external_author,  :string
    add_column :posts, :external_url,     :string
  end

  def self.down
    remove_column :posts, :feed_id
    remove_column :posts, :external_id
    remove_column :posts, :external_author
    remove_column :posts, :external_url
  end
end
