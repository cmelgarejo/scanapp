Rails.application.routes.draw do
  resources :items
  resources :companies
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
