Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :projects, only: :index do
    resources :proposals, except: [:index]
  end

  resources :users, path: :organizations, only: [:show, :new, :create, :edit, :update], as: 'organizations' do
    resources :projects
  end
  resources :users, path: :developers, only: [:show, :new, :create, :edit, :update], as: 'developers'

  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new]

  get 'login' => 'sessions#new', :as => :login
  post 'logout' => 'sessions#destroy', :as => :logout
  get "home/index"
  root :to => 'home#index'
end
