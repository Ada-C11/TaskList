Rails.application.routes.draw do
  root "tasks#index"
  resources :tasks
  post '/tasks/:id/complete', to: 'tasks#complete', as: "complete_task"

  # get '/tasks', to: 'tasks#index', as: "tasks"
  # get "/tasks/new", to: "tasks#new", as: "new_task"
  # post "/tasks", to: "tasks#create"

  # get "/tasks/:id", to: "tasks#show", as: "task"
  # get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
  # patch '/tasks/:id', to: 'tasks#update', as: "update_task"
  # delete "/tasks/:id", to: "tasks#destroy"
end
