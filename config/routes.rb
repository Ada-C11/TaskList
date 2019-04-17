Rails.application.routes.draw do
  # resources :tasks, only: [:index, :show]
  # get "/tasks", to: "tasks#index"
  get "/tasks", to: "tasks#index", as: "tasks"

  get "tasks/new", to: "tasks#new", as: "new_task"
  post "/tasks", to: "tasks#create"

  get "/tasks/:id", to: "tasks#show", as: "task"

  get "/tasks/:id/edit", to: "tasks#edit", as: "edit_task"
  patch "/tasks/:id", to: "tasks#update"

  patch "/tasks/:id/mark_complete", to: "tasks#mark_complete", as: "mark_complete"
  patch "/tasks/:id/mark_incomplete", to: "tasks#mark_incomplete", as: "mark_incomplete"

  delete "/tasks/:id", to: "tasks#destroy"

  root to: "tasks#index"
  # root to: "tasks#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
