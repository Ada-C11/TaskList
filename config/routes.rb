Rails.application.routes.draw do
  root "tasks#index"
  resources :tasks

  # get "/tasks", to: "tasks#index", as: "tasks"
  # get "/tasks/new", to: "tasks#new", as: "new_task"
  # get "/tasks/:id", to: "tasks#show", as: "task"
  # post "/tasks", to: "tasks#create"
  # delete "/tasks/:id", to: "tasks#destroy"
  # get "/tasks/:id/edit", to: "tasks#edit", as: "edit_task"
  patch "/tasks/:id", to: "tasks#update"
  patch "/tasks/:id/toggle", to: "tasks#toggle", as: "toggle"

  
end
