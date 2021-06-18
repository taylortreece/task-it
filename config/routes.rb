Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/auth/github/callback', to: 'sessions#create'

  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#logout'
  get '/signup', to: 'users#new'
  post '/signup', to: "users#create"

  root to: "application#home"

  # admin ----------------------------------------

  get '/admin/home', to: "application#admin_home"

  scope module: 'admin' do
  get '/admin/profile/:id', to: 'users#profile'
  patch '/admin/profile/:id', to: 'users#profile_form_handler'
  get '/admin/profile/:id/:edit', to: 'users#profile'
  get '/admin/profile/:id/:edit/:show_form', to: 'users#profile'
  end

  namespace :admin do
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

    resources :project_comments
    resources :segment_comments
    resources :task_comments
end

# Team Member ----------------------------------------

resources :projects, only: [:index, :show]

    resources :projects, only: [:show] do
      resources :segments, only: [:show]
    end

    resources :segments, only: [:show] do
      resources :tasks, only: [:show, :edit, :update]
    end

    resources :teams, only: [:index]

    resources :teams, only: [:show] do
      resources :users, only: [:show]
    end

    resources :tasks, only: [:index]

    resources :project_comments
    resources :segment_comments
    resources :task_comments

  get '/profile/:id', to: 'users#profile'
  patch '/profile/:id', to: 'users#profile_form_handler'
  get '/profile/:id/:edit', to: 'users#profile'
  get '/profile/:id/:edit/:show_form', to: 'users#profile'

  # Team Leader ----------------------------------------

  get '/team-leader/home', to: "application#team_leader_home"
  
  scope module: 'team_leader' do
    get '/team_leader/profile/:id', to: 'users#profile'
    patch '/team_leader/profile/:id', to: 'users#profile_form_handler'
    get '/team_leader/profile/:id/:edit', to: 'users#profile'
    get '/team_leader/profile/:id/:edit/:show_form', to: 'users#profile'
    end
  
    namespace :team_leader do
      resources :projects, only: [:index, :show] do
        resources :segments, only: [:show, :edit, :update]
      end
  
      resources :segments, only: [:show] do
        resources :tasks, only: [:show, :new, :create, :edit, :update, :destroy]
      end
      resources :teams, only: [:index]
    
      resources :teams, only: [:show] do
        resources :users, only: [:show, :new, :create, :edit, :update, :destroy]
      end
  
      resources :project_comments
      resources :segment_comments
      resources :task_comments
  end

  # match must be last route

  # match '*path', to: "application#notfound", via: [:get, :post]

  # Which routes need to be namespaced??

  # Admin Routes:

  #  All routes should be accessable to admin



  # Team Leader Routes:

  # Team leaders can only create tasks, create users, mark tasks and segments completed


  # Team Member Routes:

  # Team members can only edit their profile, mark tasks as completed, and comment.

  # routes that edit 
end
