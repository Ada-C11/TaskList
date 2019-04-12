Rails.application.routes.draw do
  root to: "tasks#index"
  # get "/tasks", to: "tasks#index", as: "tasks"

  # # add a new task
  # get "/tasks/new", to: "tasks#new", as: "new_task"
  # post "/tasks", to: "tasks#create"

  # get "/tasks/:id", to: "tasks#show", as: "task"

  resources :tasks
  # resources :tasks, only: [:index, :new, :create, :show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
