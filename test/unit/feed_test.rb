require 'test_helper'

class FeedTest < ActiveSupport::TestCase
  
  should_validate_presence_of :title, :url
  
  should_have_many :posts
  
  context 'When Fetching all the feeds' do
    setup do
      @feeds = []
      3.times {|t| @feeds << Factory(:feed, :title => "Feed #{t}", :url => "http://example.com/#{t}")}
      
      @fake_responses = []
      @feeds.each {|f| @fake_responses << [f.url, FakeResponse.new]}
      
      Feed.expects(:all).returns(@feeds)
      Feedzirra::Feed.expects(:fetch_and_parse).with(@feeds.map(&:url)).returns(@fake_responses)
      
      Feed.fetch_all
    end
    
    should_change('the number of posts', :by => 15 ) { Post.count }
    
  end
  
end

class FakeResponse
  attr_reader :entries
  
  def initialize
    @entries = []
    5.times {|t| @entries << FakeEntry.new(t)}
  end
end

class FakeEntry
  attr_reader :id, :title, :content, :author, :url, :published
  
  def initialize(t)
    @id         = "entry-#{t}"
    @title      = "Entry #{t}"
    @content    = 'Content'
    @author     = 'Matz'
    @url        = "http://example.com/entry-#{t}"
    @published  = t.hours.ago
  end
end
