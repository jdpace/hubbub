module TwitterHelper
  def link_to_twitter_image(friend)
    link_to image_tag(friend.profile_image_url, :class => 'twitter_image'), "http://www.twitter.com/#{friend.name}"
  end
  
  def unlink_twitter
    link_to 'Unlink twitter account', oauth_consumer_path(:id => :twitter), 
      :method => :delete, :confirm => 'Unlink twitter?'
  end
  
  def link_twitter
    link_to 'Link Twitter Account', oauth_consumer_path(:id => :twitter) 
  end
end