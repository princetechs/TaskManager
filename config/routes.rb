Rails.application.routes.draw do
  resources :tasks
  resources :teams do
    resources :tasks
    member do
      post 'add_member'
      # Other member management routes...
    end
  end
  
  resources :roles
  root to: 'teams#index'
  # resources :todos
  get '/signup', to: 'user#new', as: 'signup'
  post '/signup', to: 'user#create'
  get 'dashboard', to: 'user#dashboard', as: 'dashboard'
  # Routes for user sign-in and sign-out (sessions)
  get '/login', to: 'session#new', as: 'login'
  post '/login', to: 'session#create'
  delete '/logout', to: 'session#destroy', as: 'logout'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Defines the root path route ("/")
  # root "posts#index"
end
