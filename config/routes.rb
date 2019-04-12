Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'tasks#index'

  # Routes that operate on the task collection
  get "/tasks", to: "tasks#index", as: "tasks"
  get "/tasks/new", to: "tasks#new", as: "new_task"
  post "/tasks", to: "tasks#create"

  # Routes that operate on individual tasks
  get "/tasks/:id", to: "tasks#show", as: "task"
  delete '/tasks/:id', to: 'tasks#destroy'
end
