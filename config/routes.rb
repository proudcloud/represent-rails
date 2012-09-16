RepresentPh::Application.routes.draw do
  #mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :users

  match "/admin" => "places#admin"

  resources :places
  root to: "places#map" 
end
