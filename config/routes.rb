Rails.application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Peek::Railtie => '/peek'

  root to: 'visitors#index'
  resources :users
  resources :items
  resources :companies


end
