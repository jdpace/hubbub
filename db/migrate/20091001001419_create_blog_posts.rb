class CreateBlogPosts < ActiveRecord::Migration
  def self.up
    create_table :blog_posts do |t|
      t.integer         :user_id
      
      t.string          :title
      t.string          :url
      
      t.text            :body
      t.text            :body_html
      
      t.integer         :comments_count,      :default => 0
      t.integer         :last_comment_id
      
      t.timestamps
    end
    
    add_index :blog_posts, :user_id
    add_index :blog_posts, :url
  end

  def self.down
    drop_table :blog_posts
  end
end
