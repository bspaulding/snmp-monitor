ActionController::Routing::Routes.draw do |map|
  map.resources :agents

  map.root :controller => 'test'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
