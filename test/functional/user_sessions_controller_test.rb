require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  should_require_user :destroy
  
  context 'GET /user_session/new' do
    context 'when not logged in' do
      setup do
        logout
        get :new
      end
      
      should_assign_to :user_session
      should_render_template :new
    end
    
    context 'when logged in' do
      setup do
        login_as Factory(:user)
        get :new
      end
      
      should_set_the_flash_to(/You must be logged out to access this page/)
      should_redirect_to('the users account page') { account_url }
    end
  end
  
  
  context 'POST /user_session' do
    setup do
      @user = Factory(:user, :password => 'password', :password_confirmation => 'password')
      logout
    end
    
    context 'when not logged in' do
      setup do
        post :create, :user_session => {:email => @user.email, :password => 'password', :password_confirmation => 'password'}
      end
      
      should_change('the current user', :to => @user) { current_user }
      should_set_the_flash_to(/Login successful!/)
      should_redirect_to('the users account page') { account_url }
    end
    
    context 'when logged in' do
      setup do
        login_as @user
        post :create, :user_session => {:email => @user.email, :password => 'password', :password_confirmation => 'password'}
      end
      
      should_set_the_flash_to(/You must be logged out to access this page/)
      should_redirect_to('the users account page') { account_url }
    end
  end
  
  
  context 'When logged in' do
    setup do
      login_as(@user = Factory(:user))
    end
    
    context 'DELETE /user_session' do
      setup do
        delete :destroy
      end
      
      should_change('the current user', :to => nil) { current_user }
      should_set_the_flash_to(/Logout successful!/)
      should_redirect_to('the login page') { login_url }
    end
  end
  
end
