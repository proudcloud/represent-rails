Represent::Application.routes.draw do
  devise_for :users

  match "/admin" => "places#admin"

  resources :places

  resources :settings

  root to: "places#map" 
end
