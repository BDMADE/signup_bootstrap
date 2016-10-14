Signup::Engine.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'users#signup', as: 'signup'
  post 'signup', to: 'users#create'
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
