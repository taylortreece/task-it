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
  patch '/profile/:id', to: 'users#profile_form_handler'
  get '/profile/:id/:edit', to: 'users#profile'
  get '/profile/:id/:edit/:show_form', to: 'users#profile'

  resources :project_comments
  resources :segment_comments
  resources :task_comments

  # match must be last route

  match '*path', to: "application#notfound", via: [:get, :post]

  # Which routes need to be namespaced??

  # Admin Routes:

  #  All routes should be accessable to admin



  # Team Leader Routes:

  # Team leaders can only create tasks, create users, mark tasks and segments completed


  # Team Member Routes:

  # Team members can only edit their profile, mark tasks as completed, and comment.

  # routes that edit 
end
