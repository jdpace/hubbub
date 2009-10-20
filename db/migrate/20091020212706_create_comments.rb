class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer           :post_id
      
      t.integer           :user_id
      
      t.string            :author_name
      t.string            :author_email
      t.string            :author_website
      
      t.text              :body
      
      t.string            :state,         :default => 'pending'
      
      t.timestamps
    end
    
    add_index :comments, :post_id
    add_index :comments, :user_id
    add_index :comments, [:post_id, :state]
  end

  def self.down
    drop_table :comments
  end
end
