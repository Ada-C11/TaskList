Rails.application.routes.draw do
  root "tasks#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get '/tasks', to: 'tasks#index'
  # get '/tasks/new', to: 'tasks#new', as: 'new_task'
  # post '/tasks', to: 'tasks#create', as: 'create'
  # get '/tasks/:id', to: 'tasks#show', as: 'task'
  # get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
  # patch '/tasks/:id', to: 'tasks#update'
  # delete '/tasks/:id', to: 'books#destroy'
  resources :tasks #, except: [:destroy]
end

