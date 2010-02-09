ActionController::Routing::Routes.draw do |map|
  map.resources :posts do |post|
    post.resources :comments, :only => :create
  end

  map.resources :oauth_consumers,:member=>{:callback=>:get}

  map.resources :pages

  map.resources :users
  map.resource  :account, :controller => 'users'
  
  map.resource  :user_session
  map.login     '/login',   :controller => 'user_sessions', :action => :new
  map.logout    '/logout',  :controller => 'user_sessions', :action => :destroy
  
  map.resource  :dashboard
  
  map.namespace :admin do |admin|
    admin.resource :dashboard
    
    admin.resource :user_session
    admin.login     '/login',   :controller => 'user_sessions', :action => :new
    admin.logout    '/logout',  :controller => 'user_sessions', :action => :destroy
    
    admin.resources :pages
    admin.resources :posts
    
    admin.root :controller => 'dashboards', :action => 'show'
  end
  
  map.root    :controller => 'dashboards', :action => 'show'
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
