Rails.application.routes.draw do
  root to: "tasks#index", as: "root"

  # get "/tasks", to: "tasks#index", as: "tasks"
  # get "/tasks/new", to: "tasks#new", as: "new_task"
  # post "/tasks", to: "tasks#create"

  # get "/tasks/:id", to: "tasks#show", as: "task"
  # get "/tasks/:id/edit", to: "tasks#edit", as: "edit_task"
  # patch "/tasks/:id", to: "tasks#update"
  # delete "/tasks/:id", to: "task#destroy"

  resources :tasks

  patch "/task/:id/mark", to: "tasks#mark", as: "mark_task"
end
