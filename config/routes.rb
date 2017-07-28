Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :projects, :only => [:index, :show, :create, :new]

  get "home/index"
  root :to => 'home#index'
end
