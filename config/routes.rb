ActionController::Routing::Routes.draw do |map|
  
  # map.signup 'signup', :controller => 'users', :action => 'new'
  # map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  # map.login 'login', :controller => 'user_sessions', :action => 'new'
  # map.resources :user_sessions
  #  
  # map.resources :users
  
  map.devise_for :users
  
  map.resources :posts, :has_many => :comments
  map.resources :comments
  map.resources :tags
  map.resources :users, :only => :show
  
  map.root :posts

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
