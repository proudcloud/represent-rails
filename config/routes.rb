Represent::Application.routes.draw do
  devise_for :users

  match "/admin" => "places#admin"

  resources :places
  root to: "places#map" 
end
