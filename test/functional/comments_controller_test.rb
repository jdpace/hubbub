require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  
  context 'POST /posts/:post_id/comments' do
    setup do
      @post = Factory.build(:post, :url => 'post', :published_at => 1.day.ago)
      Post.stubs(:find_by_url!).with(@post.url).returns(@post)
      @comment = Factory.build(:comment, :id => 9999)
      @post.comments.stubs(:new).returns(@comment)
    end
    
    context 'when a user is logged in' do
      setup do
        @user = Factory(:user)
        login_as @user
      end
      
      context 'sending valid data' do
        setup do
          @comment.stubs(:save).returns(true)
          post :create, :post_id => @post.to_param, :comment => Factory.attributes_for(:comment)
        end
        
        should_assign_to(:post) { @post }
        should_assign_to(:comment)
        should 'set the current user as the author' do
          assert_equal @user, assigns(:comment).user
        end
        should_redirect_to('the specific comment') { post_path(@post, :anchor => "comment_#{@comment.id}")}
      end
      
      context 'sending invalid data' do
        setup do
          @comment.stubs(:save).returns(false)
          post :create, :post_id => @post.to_param, :comment => Factory.attributes_for(:comment)
        end
        
        should_assign_to(:post) { @post }
        should_assign_to(:comment)
        should 'set the current user as the author' do
          assert_equal @user, assigns(:comment).user
        end
        should_render_template 'posts/show'
      end
    end
  end
  
end
