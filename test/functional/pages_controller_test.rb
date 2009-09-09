require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  
  context 'GET /pages/:url' do
    setup do
      @page = Factory.build(:page, :url => 'url')
      Page.stubs(:find_by_url!).with('url').returns(@page)
      get :show, :id => @page.to_param
    end
    
    should_assign_to(:page) { @page }
    should_respond_with :success
  end
  
end
