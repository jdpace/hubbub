require 'test_helper'

class Admin::PostsControllerTest < ActionController::TestCase
  should_require_admin :index, :show, :create, :edit, :update, :destroy
  
  context 'Logged in as an admin/author' do
    setup do
      login_as Factory(:admin, :author => true)
    end
    
    context 'GET /admin/posts' do
      setup do
        @posts = WillPaginate::Collection.new(1, App.admin_per_page[:posts], 3)
        3.times {|t| @posts << Factory.build(:post, :url => "post-#{t}", :created_at => 1.day.ago)}
        Post.stubs(:ordered).returns(Post)
        Post.stubs(:paginate).returns(@posts)
        get :index
      end
      
      should_assign_to(:posts) { @posts }
    end
    
    
    context 'GET /admin/posts/:id' do
      setup do
        @post = Factory.build(:post, :url => 'post', :created_at => 1.day.ago)
        Post.stubs(:find_by_url!).with(@post.url).returns(@post)
        get :show, :id => @post.to_param
      end
      
      should_assign_to(:post) { @post }
    end
    
    
    context 'GET /admin/posts/new' do
      setup do
        get :new
      end
      
      should_assign_to(:post) { @post }
    end
    
    
    context 'GET /admin/posts/:id/edit' do
      setup do
        @post = Factory.build(:post, :url => 'post')
        Post.stubs(:find_by_url!).with(@post.url).returns(@post)
        get :edit, :id => @post.to_param
      end
      
      should_assign_to(:post) { @post }
    end
    
    
    context 'POST /admin/posts' do
      setup do
        @post = Factory.build(:post, :url => 'post')
        Post.stubs(:new).returns(@post)
      end
      
      context 'sending valid data' do
        setup do
          @post.stubs(:save).returns(true)
          post :create, :post => @post.attributes
        end
        
        should_assign_to(:post) { @post }
        should_set_the_flash_to %r/successfully created/
        should_redirect_to('the admin post page') { admin_post_path(@post) }
      end
      
      context 'sending invalid data' do
        setup do
          @post.stubs(:save).returns(false)
          post :create, :post => @post.attributes
        end
        
        should_assign_to(:post) { @post }
        should_render_template :new
      end
    end
    
    
    context 'PUT /admin/posts/:id' do
      setup do
        @post = Factory.build(:post, :url => 'post')
        Post.stubs(:find_by_url!).with(@post.url).returns(@post)
      end
      
      context 'sending valid data' do
        setup do
          @post.stubs(:update_attributes).returns(true)
          put :update, :id => @post.to_param, :post => @post.attributes
        end
        
        should_assign_to(:post) { @post }
        should_set_the_flash_to %r/successfully updated/
        should_redirect_to('the admin show page') { admin_post_path(@post) }
      end
      
      context 'sending invalid data' do
        setup do
          @post.stubs(:update_attributes).returns(false)
          put :update, :id => @post.to_param, :post => @post.attributes
        end
        
        should_assign_to(:post) { @post }
        should_render_template :edit
      end
    end
    
    context 'DELETE /admin/posts/:id' do
      setup do
        @post = Factory.build(:post, :url => 'post')
        Post.stubs(:find_by_url!).with(@post.url).returns(@post)
        delete :destroy, :id => @post.to_param
      end
      
      before_should 'destroy the post' do
        Post.any_instance.expects(:destroy).returns(true)
      end
      
      should_assign_to(:post) { @post }
      should_set_the_flash_to %r/successfully destroyed/
      should_redirect_to('the posts index page') { admin_posts_path }
    end
    
  end
end
