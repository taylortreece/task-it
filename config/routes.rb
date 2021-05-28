Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'application#home'

  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#logout'

  resources :projects
  resources :projects, only: [:show] do
    resources :segments, only: [:show, :new, :create, :edit, :update, :destroy]
  end

  resources :segments, only: [:show] do
    resources :tasks, only: [:show, :new, :create, :edit, :update, :destroy]
  end

  post '/projects/1/segments/new', to: "segments#create"

  resources :teams
  #resources :tasks
  resources :project_comments
  resources :segment_comments
  resources :task_comments
  resources :users
end
