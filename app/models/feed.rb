class Feed < ActiveRecord::Base
  
  has_many :posts
  
  validates_presence_of :title, :url
  
  def self.fetch_all
    feed_urls = all.map(&:url)
    
    responses = Feedzirra::Feed.fetch_and_parse(feed_urls)
    responses.each do |url, response|
      feed = find_by_url(url)
      
      response.entries.each do |entry|
        post = Post.find_or_initialize_by_feed_id_and_external_id(feed.id, entry.id) do |p|
          p.title           = entry.title
          p.body            = entry.content || entry.summary
          p.external_author = entry.author
          p.external_url    = entry.url
          p.published_at    = entry.published
          
          p.save
        end
      end
    end
  end
  
end
