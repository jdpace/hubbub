require File.join(File.dirname(__FILE__), %w[.. .. spec_helper])

describe Feedzirra::Parser::ITunesRSSOwner do
  before(:each) do
    # I don't really like doing it this way because these unit test should only rely on RSSEntry,
    # but this is actually how it should work. You would never just pass entry xml straight to the ITunesRssOwner
    @owner = Feedzirra::Parser::ITunesRSS.parse(sample_itunes_feed).itunes_owners.first
  end
  
  it "should parse the name" do
    @owner.name.should == "John Doe"
  end
  
  it "should parse the email" do
    @owner.email.should == "john.doe@example.com"
  end  

end