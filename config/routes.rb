ActionController::Routing::Routes.draw do |map|
  map.resources :pages

  map.resources :users
  map.resource  :account, :controller => 'users'
  
  map.resource  :user_session
  map.login     '/login',   :controller => 'user_sessions', :action => :new
  map.logout    '/logout',  :controller => 'user_sessions', :action => :destroy
  
  map.namespace :admin do |admin|
    admin.resource :dashboard
    admin.root :controller => 'dashboards', :action => 'show'
  end
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
