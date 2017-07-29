Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, path: :organizations, only: [:show, :new, :create, :edit], as: 'organizations'
  resources :users, path: :developers, only: [:show, :new, :create, :edit], as: 'developers'
  resources :projects
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new]

  get 'login' => 'sessions#new', :as => :login
  post 'logout' => 'sessions#destroy', :as => :logout
  get "home/index"
  root :to => 'home#index'
end
