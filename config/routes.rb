Rails.application.routes.draw do

  root :to => 'home#index'

  resources :projects, only: [:index] do
    resources :proposals, except: [:index]
  end

  resources :users, only: [:new]

  resources :users, path: :organizations, only: [:show, :new, :create, :edit, :update], as: 'organizations' do
    resources :projects, except: [:index]
  end

  resources :users, path: :developers, only: [:show, :new, :create, :edit, :update], as: 'developers'

  resources :sessions, only: [:new, :create, :destroy]

  get 'pages/about' => 'pages#about'

  get 'login' => 'sessions#new', :as => :login
  post 'logout' => 'sessions#destroy', :as => :logout

end
