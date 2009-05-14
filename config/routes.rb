ActionController::Routing::Routes.draw do |map|
  map.resources :agents

  map.root :controller => 'dashboard'
	
	map.connect '/login', :controller => 'login', :action => 'index'
	map.connect '/login/login', :controller => 'login', :action => 'login'
	map.connect '/login/logout', :controller => 'login', :action => 'logout'
	
	map.connect "/:controller/:action"
	map.connect "/:controller/:action/:id"
end
