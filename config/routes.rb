Represent::Application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" } 

  match "/admin" => "places#admin"

  resources :places
  resources :settings
  resources :users, :only => [:show,:index]

  root to: "places#map" 
end
