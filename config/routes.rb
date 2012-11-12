Represent::Application.routes.draw do
  devise_for :users

  match "/admin" => "places#admin"

  resources :places
  resources :settings
  resources :users #, :only => [:show,:index,:new,:create]

  root to: "places#map" 
end
