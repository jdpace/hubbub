require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  
  context "GET /posts" do
    setup do
      @posts = []
      3.times {|t| @posts << Factory.build(:post, :url => "post-#{t}")}
      Post.stubs(:paginate).returns(@posts)
      get :index
    end
    
    should_assign_to(:posts) { @posts }
  end
  
  
  context "Get /posts/:id" do
    setup do
      @post = Factory.build(:post, :url => 'post', :created_at => 1.day.ago)
      Post.stubs(:find).with(@post.to_param).returns(@post)
      get :show, :id => @post.to_param
    end
    
    should_assign_to(:post) { @post }
  end
  
end
