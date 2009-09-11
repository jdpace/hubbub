require 'test_helper'

class Admin::UserSessionsControllerTest < ActionController::TestCase
  should_require_admin :destroy
  
  context 'GET admin/user_session/new' do
    context 'when not logged in' do
      setup do
        activate_authlogic
        login_as nil
        get :new
      end
      
      should_assign_to :user_session
      should_render_template :new
    end
  end
  
  
  context 'POST admin/user_session' do
    setup do
      @user = Factory(:user, :password => 'password', :password_confirmation => 'password', :admin => true)
      activate_authlogic
      logout
    end
    
    context 'when not logged in' do
      setup do
        post :create, :user_session => {:email => @user.email, :password => 'password', :password_confirmation => 'password'}
      end
      
      should_change('the current user', :to => @user) { current_user }
      should_set_the_flash_to(/Login successful!/)
      should_redirect_to('the admin dashboard') { admin_root_url }
    end
  end
  
  
  context 'When logged in' do
    setup do
      activate_authlogic
      login_as(@user = Factory(:admin))
    end
    
    context 'DELETE /user_session' do
      setup do
        delete :destroy
      end
      
      should_change('the current user', :to => nil) { current_user }
      should_set_the_flash_to(/Logout successful!/)
      should_redirect_to('the admin login page') { admin_login_url }
    end
  end
  
end
