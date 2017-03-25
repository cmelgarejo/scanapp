Rails.application.routes.draw do
  mount Peek::Railtie => '/peek'

  resources :items
  resources :companies
  root to: 'visitors#index'
  devise_for :users
  resources :users

end
