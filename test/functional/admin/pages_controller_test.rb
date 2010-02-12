require 'test_helper'

class Admin::PagesControllerTest < ActionController::TestCase
  should_require_admin :index, :show, :new, :edit, :create, :update, :destroy
  
  context 'Logged in as an Admin' do
    setup do
      login_as Factory(:admin)
    end
  
    context 'GET /admin/pages' do
      setup do
        @pages = WillPaginate::Collection.new(1, App.admin_per_page[:pages], 3)
        3.times {|t| @pages << Factory.build(:page, :url => "page-#{t}") }
        Page.stubs(:paginate).returns(@pages)
        get :index
      end
      
      should_assign_to(:pages) { @pages }
    end
    
    
    context 'GET /admin/pages/:id' do
      setup do
        @page = Factory.build(:page, :url => 'page')
        Page.stubs(:find_by_url!).with(@page.to_param).returns(@page)
        get :show, :id => @page.to_param
      end
      
      should_assign_to(:page) { @page }
    end
    
    
    context 'GET /admin/pages/new' do 
      setup do
        get :new
      end
      
      should_assign_to(:page)
      should 'assign a new record to page' do
        assert assigns(:page).new_record?
      end
    end
    
    
    context 'GET /admin/pages/:id/edit' do
      setup do
        @page = Factory.build(:page, :url => 'page')
        Page.stubs(:find_by_url!).with(@page.to_param).returns(@page)
        get :edit, :id => @page.to_param
      end
      
      should_assign_to(:page) { @page }
    end
    
    
    context 'POST /admin/pages' do
      setup do
        @page       = Factory.build(:page, :url => 'page')
        Page.expects(:new).returns(@page)
      end
      
      context 'sending valid data' do
        setup do
          @page.expects(:save).returns(true)
          post :create, :page => @page.attributes
        end
        
        should_assign_to(:page) { @page }
        should_set_the_flash_to(/successfully created/)
        should_redirect_to('the show action for the new page') { admin_page_path(assigns(:page))}
      end
      
      context 'sending invalid data' do
        setup do
          @page.expects(:save).returns(false)
          post :create, :page => @page.attributes
        end
        
        should_assign_to(:page) { @page }
        should_render_template :new
      end
    end
    
    
    context 'PUT /admin/pages/:id' do
      setup do
        @page = Factory.build(:page, :url => 'page')
        Page.expects(:find_by_url!).with(@page.url).returns(@page)
      end
      
      context 'sending valid data' do
        setup do
          @page.expects(:update_attributes).returns(true)
          put :update, :id => @page.to_param, :page => @page.attributes
        end
        
        should_assign_to(:page) { @page }
        should_set_the_flash_to(/successfully updated/)
        should_redirect_to('the show action for the page') { admin_page_path(@page) }
      end
      
      context 'sending invalid data' do
        setup do
          @page.expects(:update_attributes).returns(false)
          put :update, :id => @page.to_param, :page => @page.attributes
        end
        
        should_assign_to(:page) { @page }
        should_render_template :edit
      end
    end
    
    
    context 'DELETE /admin/pages/:id' do
      setup do
        @page = Factory.build(:page)
        Page.expects(:find_by_url!).with(@page.to_param).returns(@page)
        @page.expects(:destroy).returns(true)
        delete :destroy, :id => @page.to_param
      end
      
      should_set_the_flash_to(/successfully destroyed/)
      should_redirect_to('the admin pages index') { admin_pages_path }
    end
    
  end # END logged in as an admin
  
end