require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  should_eventually "require login for :edit, :update, :destroy"
  
  context 'GET /users' do
    setup do
      @users = WillPaginate::Collection.new(1, App.per_page[:users], 3)
      3.times {|t| @users << Factory.build(:user, :id => t )}
      User.stubs(:paginate).returns(@users)
      get :index
    end
    
    should_assign_to(:users) { @users }
    should_respond_with :success
  end
  
  context 'GET /users/:id' do
    setup do
      @user = Factory.build(:user, :id => 1)
    end
    
    context 'passing an id' do
      setup do
        User.stubs(:find).with(@user.id.to_s).returns(@user)
        get :show, :id => @user.to_param
      end
    
      should_assign_to(:user) { @user }
      should_respond_with :success
    end
    
    context 'not passing an id' do
      context 'when logged in' do
        setup do
          UserSession.stubs(:find).returns(UserSession.new)
          UserSession.any_instance.stubs(:user).returns(@user)
          get :show
        end
      
        should_assign_to(:user) { current_user }
        should_respond_with :success
      end
      
      context 'when not logged in' do
        setup do
          activate_authlogic
          logout
          get :show
        end
        
        should_set_the_flash_to(/You must be logged in to access this page/)
        should_redirect_to('the login page') { login_url }
      end
    end
  end # END GET /users/:id
  
  
  context 'GET /users/new' do
    setup do
      get :new
    end
    
    should_assign_to(:user)
    should 'assign a new record to @user' do
      assert assigns(:user).new_record?
    end
  end
  
  
  context 'POST /users' do
    context 'sending valid data' do
      setup do
        post :create, :user => Factory.attributes_for(:user)
      end
      
      should_change('the total number of users', :by => 1) { User.count }
      should_set_the_flash_to(/Your account was successfully created/)
      should_redirect_to('the users account page') { account_url }
    end
    
    context 'sending invalid data' do
      setup do
        post :create, :user => Factory.attributes_for(:user, :name => '')
      end
      
      should_not_change('the total number of users') { User.count }
      should_render_template :new
    end
  end
end
