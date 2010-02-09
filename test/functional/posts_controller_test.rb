require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  
  context "GET /posts" do
    setup do
      @posts = WillPaginate::Collection.new(1, App.per_page[:posts], 3)
      3.times {|t| @posts << Factory.build(:post, :url => "post-#{t}", :published_at => 1.day.ago)}
      Post.stubs(:ordered).returns(@posts).stubs(:paginate).returns(@posts)
      get :index
    end
    
    should_assign_to(:posts) { @posts }
  end
  
  
  context "Get /posts/:id" do
    setup do
      @post = Factory.build(:post, :url => 'post', :published_at => 1.day.ago)
      Post.stubs(:find_by_url!).with(@post.to_param).returns(@post)
      get :show, :id => @post.to_param
    end
    
    should_assign_to(:post) { @post }
    should_assign_to(:comment)
  end
  
end
