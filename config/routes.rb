Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"

  resources :orders
  resources :users
  resources :products
  resources :categories
end
