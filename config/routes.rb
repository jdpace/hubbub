ActionController::Routing::Routes.draw do |map|
  map.resources :users
  map.resource  :account, :controller => 'users'
  
  map.resource  :user_session
  map.login     '/login',   :controller => 'user_sessions', :action => :new
  map.logout    '/logout',  :controller => 'user_sessions', :action => :destroy
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
