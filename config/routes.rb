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
      get 'items', to: 'items#index'
      get 'items/:id', to: 'items#show'
      get 'items/search/:search_term', to: 'items#search'
      get 'companies', to: 'companies#index'
      get 'companies/:device_id', to: 'companies#index'
      get 'countries', to: 'locations#countries'
      get 'states', to: 'locations#states'
      get 'cities', to: 'locations#cities'
      post 'authenticate', to: 'authentication#authenticate'
    end
  end


end