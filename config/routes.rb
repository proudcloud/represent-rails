RepresentPh::Application.routes.draw do
  resources :places
  root to: "places#map" 
end
