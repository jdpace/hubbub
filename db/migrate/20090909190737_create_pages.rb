class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string      :title
      t.string      :url
      
      t.text        :body
      t.text        :body_html
      
      t.boolean     :published,       :default => true
      
      t.timestamps
    end
    
    add_index :pages, :url
    add_index :pages, [:url, :published]
  end

  def self.down
    drop_table :pages
  end
end
