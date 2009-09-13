require 'test_helper'

class DashboardsControllerTest < ActionController::TestCase
  
  context 'GET /dashboard' do
    setup do
      @home_page = Factory.build(:page, :url => 'home')
      Page.expects(:find_by_url).with(@home_page.url).returns(@home_page)
      get :show
    end
    
    should_assign_to(:home_page) { @home_page }
  end
  
end
