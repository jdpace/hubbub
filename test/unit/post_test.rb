require 'test_helper'

class PostTest < ActiveSupport::TestCase
  
  should_validate_presence_of :title, :body, :user
  
  should_act_as_url :title
  
  should_belong_to :user
  should_have_many :comments
  
  context 'A Blog Post' do
    setup do
      @post = Factory(:post)
    end
    
    should 'cache the body html' do
      assert_equal "<p>#{@post.body}</p>", @post.body_html
    end
    
    should 'use the url for to_param' do
      assert_equal @post.url, @post.to_param
    end
  end
  
  context 'A Blog Post being created by a regular user' do
    setup do
      @post = Factory.build(:post, :user => Factory(:user))
      @post.save
    end
    
    should 'not be valid' do
      assert !@post.valid?
    end
    
    should 'have errors on user' do
      assert_match /author/, @post.errors.on(:user)
    end
    
    should 'not save' do
      assert !@post.save
    end
  end
  
end
