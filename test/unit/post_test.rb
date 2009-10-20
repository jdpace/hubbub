require 'test_helper'

class BlogPostTest < ActiveSupport::TestCase
  
  should_validate_presence_of :title, :body, :user
  
  should_act_as_url :title
  
  should_belong_to :user
  
  context 'A Blog Post' do
    setup do
      @blog_post = Factory(:blog_post)
    end
    
    should 'cache the body html' do
      assert_equal "<p>#{@blog_post.body}</p>", @blog_post.body_html
    end
    
    should 'use the url for to_param' do
      assert_equal @blog_post.url, @blog_post.to_param
    end
  end
  
  context 'A Blog Post being created by a regular user' do
    setup do
      @blog_post = Factory.build(:blog_post, :user => Factory(:user))
      @blog_post.save
    end
    
    should 'not be valid' do
      assert !@blog_post.valid?
    end
    
    should 'have errors on user' do
      assert_match /author/, @blog_post.errors.on(:user)
    end
    
    should 'not save' do
      assert !@blog_post.save
    end
  end
  
end
