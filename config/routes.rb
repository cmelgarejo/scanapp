Rails.application.routes.draw do

  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  #Rails admin
  #mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  mount Peek::Railtie => '/peek'

  root to: 'visitors#index'
  #resources :users
  namespace :api do #namespace :api, path: "", constraints: {:subdomain => "api"} do
    namespace :v1 do
      resources :items
      resources :companies
      post 'authenticate', to: 'authentication#authenticate'
      get 'countries', to: 'locations#countries'
      get 'states', to: 'locations#states'
      get 'cities', to: 'locations#cities'
    end
  end


end