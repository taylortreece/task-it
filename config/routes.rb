Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'application#home'

  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#logout'
  get '/signup', to: 'users#new'

  resources :projects
  resources :projects, only: [:show] do
    resources :segments, only: [:show, :new, :create, :edit, :update, :destroy]
  end

  resources :segments, only: [:show] do
    resources :tasks, only: [:show, :new, :create, :edit, :update, :destroy]
  end

  post '/projects/:id/segments/new', to: "segments#create"

  resources :teams
  resources :teams, only: [:show] do
    resources :users, only: [:show, :new, :create, :edit, :update, :destroy]
  end

  post "/teams/teams/:id/users/new", to: 'users#create'

  resources :project_comments
  resources :segment_comments
  resources :task_comments

  resources :users, only: [:show, :new, :create]
  post "/users/new", to: "users#create"
  patch "/teams/:id/users/:id/edit", to: "users#update"
end
