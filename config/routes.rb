Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'tasks#show' #re-read ada lesson this looks weird
  get '/tasks', to: 'tasks#index', as: 'tasks'
  get '/tasks/create', to: 'tasks#create', as: 'create_task'
  get '/tasks/:id', to: 'tasks#show', as: 'task'
  post '/tasks', to: 'tasks#create'
  get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
  patch '/tasks/:id', to: 'tasks#update', as: 'update_task'
  delete '/tasks/:id/delete', to: 'tasks#delete', as: 'delete_task'
  patch '/tasks/:id/toggle_complete', to: 'tasks#toggle_complete', as: 'toggle_complete_task'
end
