Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'application#home'

  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#logout'
  get '/signup', to: 'users#new'
  post '/signup', to: "users#create"

  resources :projects
  resources :projects, only: [:show] do
    resources :segments, only: [:show, :new, :create, :edit, :update, :destroy]
  end

  resources :segments, only: [:show] do
    resources :tasks, only: [:show, :new, :create, :edit, :update, :destroy]
  end

  resources :teams
  resources :teams, only: [:show] do
    resources :users, only: [:show, :new, :create, :edit, :update, :destroy]
  end

  get '/profile/:id', to: 'users#profile'
  get '/profile/:id/:edit', to: 'users#profile'
  patch '/profile/:id', to: 'users#update'

  resources :project_comments
  resources :segment_comments
  resources :task_comments

  # match must be last route

  match '*path', to: "application#notfound", via: [:get, :post]
end
