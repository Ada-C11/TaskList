Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # verb 'path', to: 'controller#action'
  # routes that operate on the task collection
  root 'tasks#index'

  get '/tasks', to: 'tasks#index', as: 'tasks'
  get '/tasks/new', to: 'tasks#new', as: 'new_task' # form
  post '/tasks', to: 'tasks#create'

  # routes that operate on individual task routes
  get '/tasks/:id', to: 'tasks#show', as: 'task'
  get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task' # form
  patch '/tasks/:id', to: 'tasks#update'
  delete '/tasks/:id', to: 'tasks#destroy'
end
