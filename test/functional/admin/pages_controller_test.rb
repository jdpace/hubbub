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
        3.times { @pages << Factory.build(:page) }
        Page.stubs(:paginate).returns(@pages)
        get :index
      end
      
      should_assign_to(:pages) { @pages }
      should_respond_with :success
    end
  end
  
end